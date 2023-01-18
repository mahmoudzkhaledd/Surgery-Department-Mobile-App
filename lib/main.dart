import 'package:flutter/material.dart';
import 'package:surgery/Model/DoctorModel.dart';
import 'package:surgery/Services/AuthServices.dart';
import 'package:surgery/Views/DoctorPage.dart';
import 'package:surgery/Views/LoginPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:surgery/Views/StartScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Services.initPrefs();
  runApp(const SurgeryApp());
}


class SurgeryApp extends StatelessWidget {

  const SurgeryApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
      theme: ThemeData(
        textTheme: GoogleFonts.aBeeZeeTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
    );
  }
}
