import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surgery/Model/DoctorModel.dart';
import 'package:surgery/Model/PatientModel.dart';
import 'package:surgery/Services/Networking.dart';
import '../Model/AdminModel.dart';


class Services {
  static Doctor? doctorModel = null;
  static Patient? patientModel = null;
  static AdminModel? adminModel = null;

  static String url = "http://${HTTP.urlLink}:3000/login";
  static String serverURL = "http://${HTTP.urlLink}:3000";
  static late SharedPreferences _prefs;

  static Future initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static const _userName = "username";
  static const _password = "password";

  static String userName = "";
  static String logPassword = "";
  static int usernameID = 0;
  static saveLogin(String uname, String pass) async {
    await _prefs.setString(_userName, uname);
    await _prefs.setString(_password, pass);
  }

  static getUserName() => _prefs.getString(_userName);

  static getPassword() => _prefs.getString(_password);

  static Future<Map<String, int>> login(String uname, String password) async {
    Map<String,int> map = {
      "ID":-1,
      "type":-1
    };
    try {
      final data = await HTTP.post(url, jsonEncode(<String, String>{'email': uname, 'password': password}));

      int x = int.parse(data['result'].toString());
      if (x > 0) {
        userName = uname;
        logPassword = password;
        map['ID'] = int.parse(data['ID'].toString());
      }
      map['type'] = x;
    } catch (e) {
      map['type'] = -2;
    }
    return map;
  }
  static logout() async{
    String url = "http://${HTTP.urlLink}:3000/logout";
    //var a =  await HTTP.post(url, jsonEncode({}));
  }
  static testConnection() async {
    try {
      await HTTP.get('${url}/test-connection');
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<dynamic> pushPage(BuildContext context, Widget page) =>
      Navigator.of(context).push(MaterialPageRoute(builder: (b) => page));

  static  pushReplacementPage(BuildContext context, Widget page) =>
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (b) => page));

  static popPage(BuildContext context) => Navigator.of(context).pop();

  static loadNotifications(int id) async {
    var notific = await HTTP.get('$serverURL/notification/$id');
    return notific;
  }

  static Future<dynamic> showMessage(BuildContext context, String message)async =>ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(fontSize: 16),
      ),
      duration: const Duration(seconds: 3),
    ),
  );
}
