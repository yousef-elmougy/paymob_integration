import 'package:flutter/material.dart';
import 'package:payment_app/shared/components/constants.dart';

class RefCode extends StatelessWidget {
  const RefCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "You should go to any market",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "This is Refrence Code => ",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  width: 10,
                ),
                Card(
                  child: Text(
                    refCode,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
