import 'package:surgery/Model/PatientModel.dart';
import 'package:surgery/Services/AuthServices.dart';
import 'dart:convert';
import 'Networking.dart';

class PatientServices{
  static Future<Patient?> getByID(int id) async {
    String url = "http://${HTTP.urlLink}:3000/pat-id/$id";

    final data = await HTTP.get(url);

    Map<String,dynamic> m = data[0];
    if (m != null) {
      return Patient.getModel(m);
    }
  }

}