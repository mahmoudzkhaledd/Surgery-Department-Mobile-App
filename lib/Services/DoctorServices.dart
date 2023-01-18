import 'dart:io';


import 'package:surgery/Model/RoomModel.dart';
import 'package:surgery/Services/AuthServices.dart';
import 'dart:convert';

import '../Model/DoctorModel.dart';
import 'Networking.dart';

class DoctorServices {
  static getByUsername(String uname, String pass) async {
    String url = "http://${HTTP.urlLink}:3000/doc-uname/$uname";
    final data = await HTTP.get(url);
    Map<String, dynamic>? m = data[0];

    if (m != null) {
      m.addAll({'password': pass});
      return Doctor.getModel(m);
    }
  }

  static getAllDocs() async {
    String url = "http://${HTTP.urlLink}:3000/all-doctors";
    final data = await HTTP.get(url);
    var m = data['reply'];
    if (m != null) {
      return m;
    }
  }

  static getDoctorOperation(int code) async {
    if (await Services.testConnection()) {
      String url = "http://${HTTP.urlLink}:3000/doc-patients";
      final data = await HTTP.post(url,jsonEncode({"code": code, "Needed": "operation"}));
      return data['reply'];
    } else {
      return null;
    }
  }

  static Future<Room?> getRoomByID(int id) async {
    if (await Services.testConnection()) {
      String url = "http://${HTTP.urlLink}:3000/room/$id";

      final data = await HTTP.get(url).timeout(const Duration(seconds: 2));
      return Room.getModel(data[0]);
    } else {
      return null;
    }
  }

  static updateData(Map<String, dynamic> map, File? image) async {
    String url = "http://${HTTP.urlLink}:3000/edit-doc";
    if (image != null) {
      String f = base64Encode(await image.readAsBytes());
      String fileName = image.path.split('/').last;
      map['image'] = f;
      map['filename'] = fileName;
    }
    final data = await HTTP.post(url, map);
  }

  static deleteNotification(int id) async {
    String url = "http://${HTTP.urlLink}:3000/delete-notification";
    await HTTP.delete(url, jsonEncode({"id": id}));
  }

}
