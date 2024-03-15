import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_app/modules/payment/cubit/cubit.dart';
import 'package:payment_app/shared/network/dio_helper.dart';
import 'modules/register/register.dart';

void main() async {
  await DioHelperPayment.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentCubit(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false, home: RegisterScreen()),
    );
  }
}
