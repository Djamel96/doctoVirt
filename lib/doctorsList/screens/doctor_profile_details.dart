import 'package:doctovirt/doctorsList/models/doctor.dart';
import 'package:doctovirt/elements/custom_card.dart';
import 'package:doctovirt/elements/rounded_button.dart';
import 'package:doctovirt/ongoingCall/screens/ongoing_call_main_screen.dart';
import 'package:doctovirt/ongoingCall/services/get_agora_token.dart';
import 'package:doctovirt/them/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../../helper/dialogs.dart';

class DoctorProfileDetails extends StatefulWidget {
  final Doctor doctor;
  const DoctorProfileDetails({super.key, required this.doctor});

  @override
  State<DoctorProfileDetails> createState() => _DoctorProfileDetailsState();
}

class _DoctorProfileDetailsState extends State<DoctorProfileDetails> {
  bool isJoining = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: CustomCardW(
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    widget.doctor.gender == 0
                        ? "assets/doctor_male_avatar_ph.png"
                        : "assets/doctor_female_avatar_ph.png",
                    width: 80,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.doctor.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.doctor.specialty.name,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade700),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.doctor.country,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Spacer(),
              Image.asset(
                "assets/doctoVirt.png",
                width: 200,
              ),
              const Spacer(
                flex: 2,
              ),
              widget.doctor.hasFree
                  ? const Text(
                      "This doctor accepts free consultancy",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.appMain100,
                      ),
                    )
                  : Text(
                      "This doctor accept paid consultancy",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blue62,
                      ),
                    ),
              const SizedBox(height: 20),
              widget.doctor.hasFree
                  ? const Text(
                      "You can call now for a free medical consultation and get advices.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  : const Text(
                      "You need to pay this doctor before you call him for a medical consultation and get advices.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
              const Spacer(
                flex: 2,
              ),
              !widget.doctor.isActive
                  ? RoundedButton(
                      content: "No available for now",
                      active: false,
                    )
                  : RoundedButton(
                      content:
                          widget.doctor.hasFree ? "Call now" : "Pay and Call",
                      onPressed: () {
                        if (widget.doctor.hasFree) {
                          _join();
                        } else {
                          showConfimMesage(context,
                              buttonConfirm: 'Ok',
                              message:
                                  'Paid consultation coming soon.\nStay tuned !');
                        }
                      },
                      loading: isJoining,
                    ),
            ],
          ),
        ),
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
