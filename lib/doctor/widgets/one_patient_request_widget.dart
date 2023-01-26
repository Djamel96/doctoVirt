import 'package:doctovirt/elements/custom_card.dart';
import 'package:doctovirt/elements/custom_inkwell.dart';
import 'package:doctovirt/elements/forward_icon.dart';
import 'package:doctovirt/elements/rounded_button.dart';
import 'package:doctovirt/ongoingCall/ongoing_call_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnePatientRequestWidget extends StatelessWidget {
  const OnePatientRequestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCardW(
      margins: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Image.asset(
                "assets/Profile-default.png",
                width: 70,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'This patient is requesting a video call for consultancy',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          RoundedButton(
            content: "Join Call",
            width: 140,
            onPressed: () => Get.to(() => const OngoingCallMainScreen()),
          )
        ],
      ),
    );
    ;
  }
}
