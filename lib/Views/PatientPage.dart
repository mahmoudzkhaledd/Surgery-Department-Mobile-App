import 'package:flutter/material.dart';
import 'package:surgery/Model/PatientModel.dart';
class PatientPage extends StatefulWidget {
  PatientPage ({Key? key,required this.patientModel})
      : super(key: key);
  Patient patientModel;

  @override
  State<PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Patient Information",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: ()async{},
          child: ListView(
            children: [

            ],
          ),
        ),
      ),
    );
  }
}
