// To parse this JSON data, do
//
//     final doctorList = doctorListFromJson(jsonString);

import 'dart:convert';

DoctorList doctorListFromJson(String str) =>
    DoctorList.fromJson(json.decode(str));

String doctorListToJson(DoctorList data) => json.encode(data.toJson());

class DoctorList {
  DoctorList({
    required this.doctors,
  });

  final List<Doctor> doctors;

  factory DoctorList.fromJson(List json) => DoctorList(
        doctors: List<Doctor>.from(json.map((x) => Doctor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "doctors": List<dynamic>.from(doctors.map((x) => x.toJson())),
      };
}

class Doctor {
  Doctor({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.specialty,
  });

  final int id;
  final String name;
  final String username;
  final String email;
  final Address address;
  final String phone;
  final String website;
  final Specialty specialty;

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        address: Address.fromJson(json["address"]),
        phone: json["phone"],
        website: json["website"],
        specialty: Specialty.fromJson(json["specialty"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "address": address.toJson(),
        "phone": phone,
        "website": website,
        "specialty": specialty.toJson(),
      };
}

class Address {
  Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });

  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final Geo geo;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        street: json["street"],
        suite: json["suite"],
        city: json["city"],
        zipcode: json["zipcode"],
        geo: Geo.fromJson(json["geo"]),
      );

  Map<String, dynamic> toJson() => {
        "street": street,
        "suite": suite,
        "city": city,
        "zipcode": zipcode,
        "geo": geo.toJson(),
      };
}

class Geo {
  Geo({
    required this.lat,
    required this.lng,
  });

  final String lat;
  final String lng;

  factory Geo.fromJson(Map<String, dynamic> json) => Geo(
        lat: json["lat"],
        lng: json["lng"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}

class Specialty {
  Specialty({
    required this.name,
    required this.id,
  });

  final String name;
  final String id;

  factory Specialty.fromJson(Map<String, dynamic> json) => Specialty(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}
