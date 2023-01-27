import 'package:doctovirt/doctorsList/models/doctor.dart';
import 'package:doctovirt/doctorsList/screens/doctor_profile_details.dart';
import 'package:doctovirt/elements/custom_card.dart';
import 'package:doctovirt/elements/custom_inkwell.dart';
import 'package:doctovirt/elements/forward_icon.dart';
import 'package:doctovirt/them/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OneDoctorWidget extends StatelessWidget {
  final Doctor doctor;
  const OneDoctorWidget({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return CustomInKWell(
      onTap: () => Get.to(() => DoctorProfileDetails(
            doctor: doctor,
          )),
      child: CustomCardW(
        margins: const EdgeInsets.only(bottom: 8),
        child: Column(children: [
          Row(
            children: [
              Image.asset(
                doctor.gender == 0
                    ? "assets/doctor_male_avatar_ph.png"
                    : "assets/doctor_female_avatar_ph.png",
                width: 70,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      doctor.specialty.name,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade700),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      doctor.country,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade600),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 13,
                          color: doctor.isActive
                              ? AppColors.appMain100
                              : AppColors.grey129,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          doctor.isActive ? "Available" : "Not Available",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: doctor.isActive
                                ? AppColors.appMain100
                                : AppColors.grey129,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const ForwardIcon()
            ],
          ),
        ]),
      ),
    );
  }
}
