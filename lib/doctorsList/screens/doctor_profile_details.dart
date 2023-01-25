import 'package:doctovirt/doctorsList/models/doctor.dart';
import 'package:doctovirt/elements/custom_card.dart';
import 'package:doctovirt/elements/rounded_button.dart';
import 'package:flutter/material.dart';

class DoctorProfileDetails extends StatefulWidget {
  final Doctor doctor;
  const DoctorProfileDetails({super.key, required this.doctor});

  @override
  State<DoctorProfileDetails> createState() => _DoctorProfileDetailsState();
}

class _DoctorProfileDetailsState extends State<DoctorProfileDetails> {
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
              const Text(
                "This doctor accepts free consultancy",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "You can call him now for a free medical consultation and get advices from him.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(
                flex: 2,
              ),
              RoundedButton(content: "Call now")
            ],
          ),
        ),
      ),
    );
  }
}
