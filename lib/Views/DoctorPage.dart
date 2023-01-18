import 'dart:math';

import 'package:flutter/material.dart';
import 'package:surgery/Model/OperationModel.dart';

import 'package:surgery/Views/DoctorProfile.dart';

import 'package:surgery/Services/AuthServices.dart';

import 'package:surgery/Services/DoctorServices.dart';
import 'package:surgery/Views/LoginPage.dart';
import 'package:surgery/Views/NotificationPage.dart';
import 'package:surgery/Views/OperationPage.dart';
import 'package:surgery/Views/SendMessage.dart';

import '../Model/DoctorModel.dart';

class DoctorPage extends StatefulWidget {
  const DoctorPage({Key? key}) : super(key: key);

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  var images = [
    'patient.png|View Patients',
    'patient.png|View Doctors',
    'patient.png|View Employees',
    'patient.png|View Nurses',
  ];
  var operations = [];

  Future<void> loadOperation() async {
    List<dynamic>? l =
        await DoctorServices.getDoctorOperation(Services.doctorModel!.code);
    operations.clear();
    if (l != null) {
      for (var element in l) {
        operations.add(Operation.getOperationModel(element));
        operations.add(Operation.getOperationModel(element));
        operations.add(Operation.getOperationModel(element));
        operations.add(Operation.getOperationModel(element));
        operations.add(Operation.getOperationModel(element));
        operations.add(Operation.getOperationModel(element));
        operations.add(Operation.getOperationModel(element));
      }
    }
    setState(() {});
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    loadOperation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      body: MainBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 25,
                  left: 20,
                  bottom: 10,
                  right: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => _scaffoldKey.currentState?.openDrawer(),
                          child: const Icon(Icons.menu),
                        ),
                        GestureDetector(
                          onTap: () {
                            Services.pushPage(
                              context,
                              NotificationPage(
                                id: Services.doctorModel!.code,
                                type: 1,
                              ),
                            );
                          },
                          child:
                              const Icon(Icons.notifications_active_outlined),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Hi, ${Services.doctorModel!.Fname} ${Services.doctorModel!.Lname}",
                      style: const TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      child: ListView(
                        padding: const EdgeInsets.only(top: 20),
                        scrollDirection: Axis.horizontal,
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: const [
                          // Column(
                          //   children: [
                          //     GestureDetector(
                          //       child: Image.asset(
                          //         "assets/images/paper-plane.png",
                          //         height: 130,
                          //       ),
                          //       onTap: () {
                          //         Services.pushPage(
                          //             context, const SendMessagePage());
                          //       },
                          //     ),
                          //     const SizedBox(
                          //       height: 20,
                          //     ),
                          //     const Text(
                          //       "Send message",
                          //       style: TextStyle(
                          //         fontSize: 15,
                          //         fontWeight: FontWeight.w600,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                    const Text(
                      "Incoming operations",
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await loadOperation();
                    setState(() {});
                  },
                  child: ListView.builder(
                    itemBuilder: (ctx, i) => OperationDrawer(
                      index: i + 1,
                      operation: operations[i],
                    ),
                    itemCount: operations.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: null),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {
                Services.pushReplacementPage(context, const DoctorPage());
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profile"),
              onTap: () => Services.pushPage(
                context,
                DoctorProfile(
                  canEdit: true,
                  doctorModel: Services.doctorModel!,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout_rounded),
              title: const Text("Log out"),
              onTap: () {
                Services.logout();
                Services.pushReplacementPage(context, const LoginPage());
                Services.doctorModel = null;
                Services.adminModel = null;
                Services.patientModel = null;
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MainBackground extends StatelessWidget {
  const MainBackground({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    double r = 200;
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          top: -1 * r + r / 2,
          left: -1 * r + r * 0.01,
          child: CircleAvatar(
            radius: r,
            backgroundColor: const Color.fromARGB(255, 190, 238, 224),
          ),
        ),
        Positioned(
          bottom: -1 * r + r / 3,
          right: -1 * r + r * 0.2,
          child: CircleAvatar(
            radius: r / 2 + 30,
            backgroundColor: const Color.fromARGB(255, 161, 203, 191),
          ),
        ),
        Positioned(
          top: -1 * r + r / 2,
          right: -1 * r + r * 0.5,
          child: CircleAvatar(
            radius: r / 2,
            backgroundColor: const Color.fromARGB(202, 48, 110, 255),
          ),
        ),
        Positioned(
          child: child,
        ),
      ],
    );
  }
}

class OperationDrawer extends StatelessWidget {
  const OperationDrawer(
      {Key? key, required this.index, required this.operation})
      : super(key: key);
  final int index;

  final Operation operation;

  @override
  Widget build(BuildContext context) {
    Color c = Colors.primaries[
        Random().nextInt(int.parse((Colors.primaries.length).toString()))];
    return GestureDetector(
      onTap: () {
        Services.pushPage(
            context,
            OperationPage(
              operationModel: operation,
              backColor: c,
            ));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 13, left: 20, right: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 225, 231, 237),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: CircleAvatar(
                backgroundColor: c,
                child: Text(
                  index.toString(),
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  operation.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(operation.name),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
