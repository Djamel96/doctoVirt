import 'package:doctovirt/chooseProfile/choose_profile_type_screen.dart';
import 'package:doctovirt/doctor/widgets/one_patient_request_widget.dart';
import 'package:doctovirt/elements/custom_inkwell.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientRequestScreen extends StatefulWidget {
  const PatientRequestScreen({super.key});

  @override
  State<PatientRequestScreen> createState() => _PatientRequestScreenState();
}

class _PatientRequestScreenState extends State<PatientRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Patients requests"),
        automaticallyImplyLeading: false,
        actions: [
          CustomInKWell(
            onTap: () {
              Get.offAll(() => const ChooseProfileTypeScreen());
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(right: 20),
              child: const Text(
                "Logout",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          OnePatientRequestWidget(),
        ],
      ),
    );
  }
}
