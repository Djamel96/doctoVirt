import 'package:doctovirt/elements/custom_card.dart';
import 'package:doctovirt/elements/custom_inkwell.dart';
import 'package:doctovirt/elements/forward_icon.dart';
import 'package:doctovirt/elements/rounded_button.dart';
import 'package:doctovirt/helper/dialogs.dart';
import 'package:doctovirt/ongoingCall/screens/ongoing_call_main_screen.dart';
import 'package:doctovirt/ongoingCall/services/get_agora_token.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnePatientRequestWidget extends StatefulWidget {
  const OnePatientRequestWidget({super.key});

  @override
  State<OnePatientRequestWidget> createState() =>
      _OnePatientRequestWidgetState();
}

class _OnePatientRequestWidgetState extends State<OnePatientRequestWidget> {
  bool isJoining = false;
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
            onPressed: () {
              _join();
            },
            loading: isJoining,
          )
        ],
      ),
    );
  }

  _join() {
    if (isJoining) return;
    setState(() {
      isJoining = true;
    });
    getAgoraToken().then((value) {
      if (mounted) {
        setState(() {
          isJoining = false;
        });
        if (value.success) {
          Get.to(() => OngoingCallMainScreen(
                token: value.value,
              ));
        } else {
          showConfimMesage(context,
              buttonConfirm: 'Ok', message: "Can't join now.\n Try later");
        }
      }
    });
  }
}
