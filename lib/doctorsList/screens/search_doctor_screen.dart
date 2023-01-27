import 'package:doctovirt/doctorsList/models/doctor.dart';
import 'package:doctovirt/doctorsList/services/search_doctor_service.dart';
import 'package:doctovirt/doctorsList/widgets/one_doctor.dart';
import 'package:doctovirt/elements/rich_text_field.dart';
import 'package:flutter/material.dart';

class SearchDoctorScreen extends StatefulWidget {
  const SearchDoctorScreen({super.key});

  @override
  State<SearchDoctorScreen> createState() => _SearchDoctorScreenState();
}

class _SearchDoctorScreenState extends State<SearchDoctorScreen> {
  List<Doctor> searchedDoctors = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search doctor"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(children: [
          RichTextField(
            onChanged: _searchDoctors,
            hintText: "Search by name or specialty...",
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
                padding: const EdgeInsets.all(16),
                children: List<Widget>.generate(
                    searchedDoctors.length,
                    (index) => OneDoctorWidget(
                          doctor: searchedDoctors[index],
                        ))),
          ),
        ]),
      ),
    );
  }

  _searchDoctors(String val) {
    setState(() {
      searchedDoctors = searchDoctors(val.toLowerCase());
    });
  }
}
