import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_app/modules/payment/cubit/cubit.dart';
import 'package:payment_app/modules/payment/cubit/states.dart';
import 'package:payment_app/modules/payment/toggle.dart';
import 'package:payment_app/shared/components/components.dart';
import 'package:payment_app/shared/styles/colors.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var priceController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state is PaymentRefCodeSuccessState) {
          navigateTo(context, const ToggleScreen());
        }
      },
      builder: (context, state) {
        return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              backgroundColor: defColor,
              title: const Center(child: Text("Payment Integration")),
            ),
            body: SafeArea(
                child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      defaultFormField(
                          controller: firstNameController,
                          type: TextInputType.name,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "Please enter your first name";
                            }
                            return null;
                          },
                          label: 'FirstName',
                          prefix: Icons.person),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                          controller: lastNameController,
                          type: TextInputType.name,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "Please enter your last name";
                            }
                            return null;
                          },
                          label: 'LastName',
                          prefix: Icons.person),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "Please enter your email";
                            }
                            return null;
                          },
                          label: 'email',
                          prefix: Icons.email),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "Please enter your phone";
                            }
                            return null;
                          },
                          label: 'phone',
                          prefix: Icons.phone),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                          controller: priceController,
                          type: TextInputType.number,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "Please enter your price";
                            }
                            return null;
                          },
                          label: 'price',
                          prefix: Icons.price_check),
                      const SizedBox(
                        height: 40,
                      ),
                      defaultButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              PaymentCubit.get(context).getFirstToken(
                                  firstNameController.text,
                                  lastNameController.text,
                                  emailController.text,
                                  phoneController.text,
                                  priceController.text);
                            }
                          },
                          text: 'Pay',
                          width: 140,
                          radius: 10)
                    ],
                  ),
                ),
              ),
            )));
      },
    );
  }
}
