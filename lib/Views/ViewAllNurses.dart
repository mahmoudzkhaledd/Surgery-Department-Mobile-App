import 'package:flutter/material.dart';
import 'package:surgery/Services/EmployeeServices.dart';

import '../Model/NurseModel.dart';
import '../Model/PatientModel.dart';
import '../Services/AuthServices.dart';
import 'PatientPage.dart';

class ViewAllNurses extends StatefulWidget {
  const ViewAllNurses({Key? key}) : super(key: key);

  @override
  State<ViewAllNurses> createState() => _ViewAllNursesState();
}

class _ViewAllNursesState extends State<ViewAllNurses> {
  List<Nurse> nursesList = [];

  Future<void> loadAllDoctors() async {
    nursesList.clear();
    var l = await AdminServices.getAllNurses();
    for (Map<String, dynamic> i in l) {
      nursesList.add(Nurse.getModel(i));
    }
    setState(() {});
  }

  deleteDoctor(int code, int usernameID) async {
    await AdminServices.deleteDoctor(code, usernameID);
    loadAllDoctors();
    setState(() {});
  }

  @override
  void initState() {
    loadAllDoctors();
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
          "All Nurses",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: loadAllDoctors,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 20),
            itemCount: nursesList.length,
            itemBuilder: (ctx, index) {
              return NurseCard(
                nursestModel: nursesList[index],
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

class NurseCard extends StatelessWidget {
  NurseCard(
      {Key? key,
        required this.nursestModel,
        required this.width,
        required this.onTap})
      : super(key: key);
  final VoidCallback onTap;
  final Nurse nursestModel;
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
                backgroundImage: AssetImage("assets/images/nurse.png"),
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
                      "${nursestModel.FName} ${nursestModel.LName}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.4,
                    child: Text(
                      nursestModel.Email,
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
