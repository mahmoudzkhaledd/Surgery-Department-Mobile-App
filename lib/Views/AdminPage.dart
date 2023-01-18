import 'package:flutter/material.dart';
import 'package:surgery/Services/EmployeeServices.dart';
import 'package:surgery/Views/AddNurse.dart';
import 'package:surgery/Views/NotificationPage.dart';
import 'package:surgery/Views/OverView.dart';
import 'package:surgery/Views/SendMessage.dart';

import '../Services/AuthServices.dart';
import 'AddDoctorPage.dart';
import 'LoginPage.dart';
import 'ViewBalancePage.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double balance = 0.0;

  Future<void> getHospitalBalance() async {
    try{balance = await AdminServices.getHospitalBalance();}catch(e){}
    setState(() {});
  }

  @override
  void initState() {
    getHospitalBalance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          child: const Icon(
            Icons.menu,
            color: Colors.black,
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
              onTap: () {},
            ),
            ListTile(
                leading: const Icon(Icons.person),
                title: const Text("Profile"),
                onTap: () {},
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
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: getHospitalBalance,
          child: ListView(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
            ),
            children: [
              const Text(
                "Hello,",
                style: TextStyle(
                  fontSize: 35,
                  fontFamily: 'Neuzeit Regular',
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 186, 192, 203),
                ),
              ),
              Text(
                "MR. ${Services.adminModel!.FName} ${Services.adminModel!.LName}",
                style: const TextStyle(
                  fontSize: 35,
                  fontFamily: 'Neuzeit bold',
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 19, 40, 72),
                ),
              ),
              const SizedBox(height: 45),
              Card(
                color: const Color.fromARGB(255, 10, 36, 77),
                elevation: 7,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Total Balance",
                        style: TextStyle(
                          fontFamily: 'Neuzeit Regular',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "",
                          children: [
                            TextSpan(
                              text: "$balance ",
                              style: const TextStyle(
                                fontFamily: 'Neuzeit bold',
                                fontSize: 35,
                              ),
                            ),
                            const TextSpan(
                              text: "LE",
                              style: TextStyle(
                                fontFamily: 'Neuzeit Regular',
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: double.infinity,
                        height: 25,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Services.pushPage(context, const ViewBalancePage());
                          },
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 27, 77, 255),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              "View Balance",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: w - 40,
                child: Row(
                  children: [
                    HorizontalCards(
                      onTap: () {
                        Services.pushPage(context, const SendMessagePage());
                      },
                      width: w,
                      text: 'Send Email',
                      leftIcon: Icons.add,
                      rightIcon: Icons.email_outlined,
                    ),
                    HorizontalCards(
                      onTap: () {
                        Services.pushPage(context, NotificationPage(id: Services.adminModel!.ID,type: 2,));
                      },
                      width: w,
                      text: 'Received Emails',
                      leftIcon: Icons.email_rounded,
                      rightIcon: Icons.photo,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ActionClass(
                title: 'Department Overview',
                description: 'Take an overview of your department.',
                buttonText: 'View',
                width: w,
                onTap: () {
                  Services.pushPage(context,const OverViewPage());
                },
              ),
              const Divider(thickness: 1),
              const SizedBox(height: 15),
              ActionClass(
                title: 'Hire new Doctor',
                description: 'Add new doctor to database.',
                buttonText: "let's Go",
                width: w,
                onTap: () {
                  Services.pushPage(context,const AddDoctorPage());
                },
              ),
              const Divider(thickness: 1),
              const SizedBox(height: 15),
              ActionClass(
                title: 'Hire new Nurse',
                description: 'Add new Nurse to database.',
                buttonText: "let's Go",
                width: w,
                onTap: () {
                  Services.pushPage(context,const AddNursePage());
                },
              ),
              const Divider(thickness: 1),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class HorizontalCards extends StatelessWidget {
  const HorizontalCards({
    Key? key,
    required this.onTap,
    required this.width,
    required this.text,
    required this.leftIcon,
    required this.rightIcon,
  }) : super(key: key);
  final double width;
  final VoidCallback onTap;
  final String text;
  final IconData rightIcon;
  final IconData leftIcon;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Card(
        color: Colors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: (width - 90) / 2,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    GestureDetector(
                      onTap: onTap,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          color: const Color.fromARGB(255, 27, 77, 255),
                        ),
                        child: Icon(
                          leftIcon,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Icon(rightIcon, size: 40)
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                text,
                style: const TextStyle(
                  fontFamily: 'Neuzeit bold',
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ActionClass extends StatelessWidget {
  const ActionClass(
      {Key? key,
      required this.title,
      required this.onTap,
      required this.description,
      required this.buttonText,
      required this.width})
      : super(key: key);
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width - 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 2,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "$title\n",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 20, 41, 74),
                      fontFamily: 'Neuzeit bold',
                      fontSize: 21,
                    ),
                  ),
                  TextSpan(
                    text: description,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 27, 77, 255),
                  borderRadius: BorderRadius.circular(8.5),
                ),
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
