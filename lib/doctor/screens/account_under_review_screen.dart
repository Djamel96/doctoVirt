import 'package:doctovirt/elements/custom_card.dart';
import 'package:doctovirt/elements/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountUnderReviewScreen extends StatefulWidget {
  const AccountUnderReviewScreen({super.key});

  @override
  State<AccountUnderReviewScreen> createState() =>
      _AccountUnderReviewScreenState();
}

class _AccountUnderReviewScreenState extends State<AccountUnderReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account review"),
      ),
      body: CustomCardW(
          margins: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset(
                "assets/doctoVirt.png",
                width: 250,
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Thank you for the trust. We will review your request and contact you very soon to verify your account.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const Spacer(),
              RoundedButton(
                content: "Ok Thanks !",
                onPressed: () => Get.back(),
              )
            ],
          )),
    );
  }
}
