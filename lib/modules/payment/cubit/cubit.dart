import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_app/models/first_token.dart';
import 'package:payment_app/modules/payment/cubit/states.dart';
import 'package:payment_app/shared/components/constants.dart';
import 'package:payment_app/shared/network/dio_helper.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitialState());

  static PaymentCubit get(context) => BlocProvider.of(context);

  //auth token

  FirstToken? firstToken;
  Future getFirstToken(String firstName, String lastName, String email,
      String phone, String price) async {
    DioHelperPayment.postData(
        url: 'auth/tokens', data: {"api_key": paymobApiKey}).then((value) {
      //var firstToken = FirstToken.fromJson(value.data);
      //paymobToken = firstToken.token;
      paymobToken = value.data['token'];
      print("first token : $paymobToken");
      getOrderId(firstName, lastName, email, phone, price);
      emit(PaymentSuccessState());
    }).catchError((error) {
      print("error : $error");
      emit(PaymentErrorState(error.toString()));
    });
  }

  Future getOrderId(String firstName, String lastName, String email,
      String phone, String price) async {
    DioHelperPayment.postData(url: 'ecommerce/orders', data: {
      "auth_token": paymobToken,
      "delivery_needed": "false",
      "amount_cents": price,
      "items": []
    }).then((value) {
      orderId = value.data['id'].toString();
      print("order Id : $orderId");
      getFinalTokenCard(firstName, lastName, email, phone, price);
      getFinalTokenKiosk(firstName, lastName, email, phone, price);
      emit(PaymentOrderIDSuccessState());
    }).catchError((error) {
      print("error : $error");
      emit(PaymentOrderIDErrorState(error.toString()));
    });
  }

  Future getFinalTokenCard(String firstName, String lastName, String email,
      String phone, String price) async {
    DioHelperPayment.postData(url: 'acceptance/payment_keys', data: {
      "auth_token": paymobToken,
      "amount_cents": price,
      "expiration": 3600,
      "order_id": orderId,
      "billing_data": {
        "apartment": "NA",
        "email": email,
        "floor": "NA",
        "first_name": firstName,
        "street": "NA",
        "building": "NA",
        "phone_number": phone,
        "shipping_method": "NA",
        "postal_code": "NA",
        "city": "NA",
        "country": "NA",
        "last_name": lastName,
        "state": "NA"
      },
      "currency": "EGP",
      "integration_id": intgrationIdCard,
      "lock_order_when_paid": "false"
    }).then((value) {
      finalTokenCard = value.data['token'].toString();
      print("finalTokenCard : $finalTokenCard");
      getRefCode();
      emit(PaymentRequestTokenCardSuccessState());
    }).catchError((error) {
      print("error : $error");
      emit(PaymentRequestTokenCardErrorState(error.toString()));
    });
  }

  Future getFinalTokenKiosk(String firstName, String lastName, String email,
      String phone, String price) async {
    DioHelperPayment.postData(url: 'acceptance/payment_keys', data: {
      "auth_token": paymobToken,
      "amount_cents": price,
      "expiration": 3600,
      "order_id": orderId,
      "billing_data": {
        "apartment": "NA",
        "email": email,
        "floor": "NA",
        "first_name": firstName,
        "street": "NA",
        "building": "NA",
        "phone_number": phone,
        "shipping_method": "NA",
        "postal_code": "NA",
        "city": "NA",
        "country": "NA",
        "last_name": lastName,
        "state": "NA"
      },
      "currency": "EGP",
      "integration_id": intgrationIdKiosk,
      "lock_order_when_paid": "false"
    }).then((value) {
      finalTokenKiosk = value.data['token'].toString();
      print("finalTokenKiosk : $finalTokenKiosk");
      emit(PaymentRequestTokenKioskSuccessState());
    }).catchError((error) {
      print("error : $error");
      emit(PaymentRequestTokenKioskErrorState(error.toString()));
    });
  }

  Future getRefCode() async {
    DioHelperPayment.postData(url: 'acceptance/payments/pay', data: {
      "source": {"identifier": "AGGREGATOR", "subtype": "AGGREGATOR"},
      "payment_token": finalTokenKiosk
    }).then((value) {
      refCode = value.data['id'].toString();
      print("refCode : $refCode");
      emit(PaymentRefCodeSuccessState());
    }).catchError((error) {
      print("error : $error");
      emit(PaymentRefCodeErrorState(error.toString()));
    });
  }
}
