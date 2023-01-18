import 'package:surgery/Model/AdminModel.dart';
import 'dart:convert';
import '../Model/DoctorModel.dart';
import 'AuthServices.dart';
import 'Networking.dart';

class AdminServices {
  static Future<AdminModel?> getByUsername(String uname, String pass) async {
    String url = "http://${HTTP.urlLink}:3000/admin-$uname";

    final data = await HTTP.get(url);

    Map<String, dynamic>? m = data['model'];

    if (m != null) {
      m.addAll({'password': pass});
      return AdminModel.getModel(m);
    }
  }

  static Future<double> getHospitalBalance() async {
    String url = "http://${HTTP.urlLink}:3000/admin-balance";
    final data = await HTTP.get(url);
    double m = double.parse(data['balance'].toStringAsFixed(2));
    return m;
  }

  static Future<Map<String, dynamic>> getOverview() async {
    Map<String, dynamic> map = {};
    String url = "http://${HTTP.urlLink}:3000/m-dashboard";
    final data = await HTTP.get(url);
    map = data['overView'][0];
    return map;
  }

  static Future<bool> sendNotification(int msgto, String content) async {
    String url = "http://${HTTP.urlLink}:3000/notification";
    if (await Services.testConnection()) {
      final data = await HTTP
          .post(url, jsonEncode(<String, dynamic>{
        "msgfrom": Services.adminModel!.ID,
        "msgto": msgto,
        "content": content
      }));
      return data['reply'];
    } else {
      return false;
    }
  }

  static Future<void> deleteDoctor(int code, int usernameID) async {
    String url = "http://${HTTP.urlLink}:3000/delete-doc";
    var x = await HTTP.delete(url, jsonEncode({"code": code, 'usernameID': usernameID}));
  }

  static getAllPatients() async {
    Map<String, dynamic> map = {};
    String url = "http://${HTTP.urlLink}:3000/all-patients";
    final data = await HTTP.get(url);
    return data;
  }

  static getAllNurses() async {
    Map<String, dynamic> map = {};
    String url = "http://${HTTP.urlLink}:3000/all-nurses";
    final data = await HTTP.get(url);
    return data;
  }

  static Future<bool> addDoctor(Map<String, String> mp) async {
    String url = "http://${HTTP.urlLink}:3000/new-doctor";
    final data = await HTTP.post(url,jsonEncode(mp));
    return data['reply'] == true;
  }
  static Future<bool> addNurse(Map<String, String> mp) async {
    String url = "http://${HTTP.urlLink}:3000/new-nurse";
    final data = await HTTP.post(url, jsonEncode(mp));
    return data as bool;
  }
}
