import 'package:doctovirt/doctorsList/models/doctor.dart';
import 'package:doctovirt/doctorsList/services/get_doctors.dart';
import 'package:doctovirt/doctorsList/widgets/one_doctor.dart';
import 'package:doctovirt/them/colors.dart';
import 'package:flutter/material.dart';

class DoctorsListMainScreen extends StatefulWidget {
  const DoctorsListMainScreen({super.key});

  @override
  State<DoctorsListMainScreen> createState() => _DoctorsListMainScreenState();
}

class _DoctorsListMainScreenState extends State<DoctorsListMainScreen> {
  List<Doctor> doctors = [];
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      doctors = getDoctors();
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        title: const Text("Doctors List"),
      ),
      body: ListView(
          padding: const EdgeInsets.all(16),
          children: List<Widget>.generate(
              doctors.length,
              (index) => OneDoctorWidget(
                    doctor: doctors[index],
                  ))),
    );
  }
}
