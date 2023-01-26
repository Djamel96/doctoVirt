import 'package:doctovirt/doctor/widgets/one_patient_request_widget.dart';
import 'package:flutter/material.dart';

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
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [const OnePatientRequestWidget()],
      ),
    );
  }
}
