import 'package:doctovirt/doctorsList/models/doctor.dart';
import 'package:doctovirt/doctorsList/screens/search_doctor_screen.dart';
import 'package:doctovirt/doctorsList/services/get_doctors.dart';
import 'package:doctovirt/doctorsList/widgets/one_doctor.dart';
import 'package:doctovirt/elements/custom_inkwell.dart';
import 'package:doctovirt/them/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        actions: [
          CustomInKWell(
            onTap: () => Get.to(() => const SearchDoctorScreen()),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.search),
                SizedBox(width: 8),
                Text(
                  "Search",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                SizedBox(width: 20),
              ],
            ),
          )
        ],
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
