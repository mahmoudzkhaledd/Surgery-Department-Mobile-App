import 'package:flutter/material.dart';
import 'package:surgery/Views/LoginPage.dart';

import '../Model/DoctorModel.dart';
import '../Services/AuthServices.dart';
import '../Services/DoctorServices.dart';
import 'DoctorPage.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  Doctor? docModel = null;

  Future<void> checkLoginToPage() async {
    // String username = Services.getUserName() ?? '';
    // String password = Services.getPassword() ?? '';
    // if (username != '' && password != '') {
    //   int a = await Services.login(username, password);
    //   if (a > 0) {
    //     if (a == 1) {
    //       docModel = await DoctorServices.getByUsername(username, password);
    //       return;
    //     }
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return FutureBuilder(
      future: checkLoginToPage(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: const AssetImage("assets/images/healthcare.png"),
                    width: w * 0.5,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Welcome",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const CircularProgressIndicator(),
                ],
              ),
            ),
          );
        } else {
          return docModel == null ? const LoginPage() : DoctorPage();
        }
      },
    );
  }
}
