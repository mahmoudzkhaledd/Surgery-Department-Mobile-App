import 'package:flutter/material.dart';
import 'package:surgery/Services/AuthServices.dart';
import 'package:surgery/Services/EmployeeServices.dart';
import 'package:surgery/Views/ViewAllDoctors.dart';

import 'AdminPage.dart';
import 'ViewAllNurses.dart';
import 'ViewAllPatients.dart';

class OverViewPage extends StatefulWidget {
  const OverViewPage({Key? key}) : super(key: key);

  @override
  State<OverViewPage> createState() => _OverViewPageState();
}

class _OverViewPageState extends State<OverViewPage> {
  Map<String, dynamic> overView = {
    'doctor': 0,
    'patient': 0,
    'nurse': 0,
    'employee': 0
  };

  Future<void> loadOverview() async {
    overView = await AdminServices.getOverview();
    setState(() {});
  }

  @override
  void initState() {
    loadOverview();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: loadOverview,
          child: ListView(
            padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Services.popPage(context);
                    },
                    child: const Icon(Icons.arrow_back),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                "Overview",
                style: TextStyle(
                  fontFamily: 'Neuzeit bold',
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 19, 40, 72),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  OverviewCard(
                    description: "Number of doctors.",
                    number: overView['doctor'].toString(),
                    color: const Color.fromARGB(255, 28, 77, 253),
                  ),
                  OverviewCard(
                    description: "Number of Nurses.",
                    number: overView['nurse'].toString(),
                    color: const Color.fromARGB(255, 18, 48, 95),
                  ),
                ],
              ),
              
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  OverviewCard(
                    description: "Number of Employees.",
                    number: overView['employee'].toString(),
                    color: Colors.white,
                  ),
                  OverviewCard(
                    description: "Number of Patients.",
                    number: overView['patient'].toString(),
                    color: const Color.fromARGB(255, 184, 151, 137),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              ActionClass(
                title: 'View All Patients',
                onTap: () {
                  Services.pushPage(context, const ViewAllPatients());
                },
                description: 'View all patients in the department.',
                buttonText: 'View',
                width: w,
              ),
              const Divider(thickness: 1),
              const SizedBox(height: 15),
              ActionClass(
                title: 'View All Doctors',
                onTap: () {
                  Services.pushPage(context, const ViewAllDoctors());
                },
                description: 'View all doctors in the department.',
                buttonText: 'View',
                width: w,
              ),
              const Divider(thickness: 1),
              const SizedBox(height: 15),
              ActionClass(
                title: 'View All Nurses',
                onTap: () {
                  Services.pushPage(context, const ViewAllNurses());
                },
                description: 'View all nurses in the department.',
                buttonText: 'View',
                width: w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OverviewCard extends StatelessWidget {
  const OverviewCard(
      {Key? key,
      required this.description,
      required this.number,
      required this.color})
      : super(key: key);
  final String description;
  final String number;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(25),
          color: color,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              number.toString(),
              style: TextStyle(
                color: color != Colors.white ? Colors.white : Colors.black,
                fontSize: 35,
                fontFamily: 'Neuzeit bold',
              ),
            ),
            Text(
              description,
              style: TextStyle(
                color: color != Colors.white ? Colors.white : Colors.black,
                fontSize: 20,
                fontFamily: 'Neuzeit Reqular',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
