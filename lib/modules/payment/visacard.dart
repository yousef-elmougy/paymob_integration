import 'package:flutter/material.dart';
import 'package:payment_app/modules/register/register.dart';
import 'package:payment_app/shared/components/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';

class VisaCard extends StatelessWidget {
  const VisaCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Visa Card"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  exit(context);
                },
                icon: const Icon(Icons.exit_to_app))
          ],
        ),
        body: WebView(
          initialUrl:
              "https://accept.paymob.com/api/acceptance/iframes/678089?payment_token=$finalTokenCard",
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }

  exit(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              "Do you want to exit ?",
              style: TextStyle(color: defColor, fontSize: 14),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    navigateAndFinish(context, RegisterScreen());
                  },
                  child: const Text("Yes", style: TextStyle(color: defColor))),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("No", style: TextStyle(color: defColor)))
            ],
          );
        });
  }
}
