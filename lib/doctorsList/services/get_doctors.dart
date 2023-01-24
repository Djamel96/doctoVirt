import '../models/doctor.dart';
import '../models/doctor_list.dart';

getDoctors() {
  return DoctorList.fromJson(doctors).doctors;
}
