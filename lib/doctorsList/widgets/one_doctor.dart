import 'package:doctovirt/doctorsList/models/doctor.dart';
import 'package:doctovirt/elements/custom_card.dart';
import 'package:flutter/material.dart';

class OneDoctorWidget extends StatelessWidget {
  final Doctor doctor;
  const OneDoctorWidget({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return CustomCardW(
      margins: EdgeInsets.only(bottom: 8),
      child: Column(children: [
        Row(
          children: [Text(doctor.name)],
        )
      ]),
    );
  }
}
