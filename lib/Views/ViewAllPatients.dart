import 'package:flutter/material.dart';
import 'package:surgery/Services/EmployeeServices.dart';
import '../Model/PatientModel.dart';
import '../Services/AuthServices.dart';
import 'PatientPage.dart';

class ViewAllPatients extends StatefulWidget {
  const ViewAllPatients({Key? key}) : super(key: key);

  @override
  State<ViewAllPatients> createState() => _ViewAllPatientsState();
}

class _ViewAllPatientsState extends State<ViewAllPatients> {
  List<Patient> patientList = [];

  Future<void> loadAllPatients() async {
    patientList.clear();
    var l = await AdminServices.getAllPatients();
    for (Map<String, dynamic> i in l) {
      patientList.add(Patient.getModel(i));
    }
    setState(() {});
  }

  deletePatient(int code, int usernameID) async {
    await AdminServices.deleteDoctor(code, usernameID);
    loadAllPatients();
    setState(() {});
  }

  @override
  void initState() {
    loadAllPatients();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "All Patients",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: loadAllPatients,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 20),
            itemCount: patientList.length,
            itemBuilder: (ctx, index) {
              return PatientCard(
                patientModel: patientList[index],
                onTap: () {},
                width: w,
              );
            },
          ),
        ),
      ),
    );
  }
}

class PatientCard extends StatelessWidget {
  PatientCard(
      {Key? key,
      required this.patientModel,
      required this.width,
      required this.onTap})
      : super(key: key);
  final VoidCallback onTap;
  final Patient patientModel;
  final double width;
  double contHeight = 90;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        right: 20,
        left: 20,
      ),
      width: width - 20,
      height: contHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage("assets/images/patient-image.png"),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width * 0.4,
                    child: Text(
                      "${patientModel.FName} ${patientModel.LName}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.4,
                    child: Text(
                      patientModel.Email,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Services.pushPage(
                      context, PatientPage(patientModel: patientModel));
                },
                child: const Icon(Icons.person),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
