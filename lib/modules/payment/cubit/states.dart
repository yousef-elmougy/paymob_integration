abstract class PaymentState {}

class PaymentInitialState extends PaymentState {}

class PaymentSuccessState extends PaymentState {}

class PaymentErrorState extends PaymentState {
  String error;
  PaymentErrorState(this.error);
}

class PaymentOrderIDSuccessState extends PaymentState {}

class PaymentOrderIDErrorState extends PaymentState {
  String error;
  PaymentOrderIDErrorState(this.error);
}

class PaymentRequestTokenCardSuccessState extends PaymentState {}

class PaymentRequestTokenCardErrorState extends PaymentState {
  String error;
  PaymentRequestTokenCardErrorState(this.error);
}

class PaymentRequestTokenKioskSuccessState extends PaymentState {}

class PaymentRequestTokenKioskErrorState extends PaymentState {
  String error;
  PaymentRequestTokenKioskErrorState(this.error);
}

class PaymentRefCodeSuccessState extends PaymentState {}

class PaymentRefCodeErrorState extends PaymentState {
  String error;
  PaymentRefCodeErrorState(this.error);
}
