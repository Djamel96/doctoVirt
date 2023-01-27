import 'package:doctovirt/doctorsList/models/doctor.dart';
import 'package:doctovirt/doctorsList/models/doctor_list.dart';

List<Doctor> searchDoctors(String keyWord) {
  List<Doctor> doctorList = DoctorList.fromJson(doctors).doctors;
  List<Doctor> matchedDoctors = [];

  if (keyWord.isNotEmpty) {
    for (Doctor doc in doctorList) {
      if (doc.name.toLowerCase().contains(keyWord) ||
          doc.specialty.name.toLowerCase().contains(keyWord)) {
        matchedDoctors.add(doc);
      }
    }
  }

  return matchedDoctors;
}
