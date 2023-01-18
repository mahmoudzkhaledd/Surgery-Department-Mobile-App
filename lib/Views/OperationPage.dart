import 'package:flutter/material.dart';
import 'package:surgery/Model/OperationModel.dart';
import 'package:surgery/Services/AuthServices.dart';
import 'package:surgery/Services/DoctorServices.dart';
import 'package:surgery/Services/PatientServices.dart';
import 'package:surgery/Views/PatientPage.dart';

import '../Model/PatientModel.dart';
import '../Model/RoomModel.dart';

class OperationPage extends StatefulWidget {
  OperationPage(
      {Key? key, required this.operationModel, required this.backColor})
      : super(key: key);

  final Operation operationModel;
  final Color backColor;


  @override
  State<OperationPage> createState() => _OperationPageState();
}

class _OperationPageState extends State<OperationPage> {
  Room? roomModel = null;
  Patient? patientModel = null;
  @override
  initState() {
    getRoomModel();
    getPatientModel();
    super.initState();
  }
  getPatientModel() async {
    patientModel = await PatientServices.getByID(widget.operationModel.patient);
    patientModel ??= Patient()..FName = 'Unknown';
    setState(() {});
  }
  getRoomModel() async {
    roomModel =
    await DoctorServices.getRoomByID(widget.operationModel.roomId);
    roomModel ??= Room()..Name = "Unknown";

    setState(() {});
  }

  late String roomName;

  operationData(String title, String data) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: "$title: ",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: data,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery
        .of(context)
        .size
        .width;
    double h = MediaQuery
        .of(context)
        .size
        .height;
    bool showMore = false;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: widget.backColor,
            pinned: true,
            toolbarHeight: 70,
            expandedHeight: 300,
            title: GestureDetector(
              onTap: () {
                Services.popPage(context);
              },
              child: const CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                child: Icon(Icons.close),
              ),
            ),
            flexibleSpace: const FlexibleSpaceBar(
              background: Image(
                image: AssetImage("assets/images/Online-Doctor-pana.png"),
                width: double.maxFinite,
                fit: BoxFit.contain,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(30),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                alignment: Alignment.center,
                width: double.infinity,
                child: Text(
                  widget.operationModel.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  operationData(
                      "Room",
                      roomModel != null
                          ? roomModel!.Name
                          : "Unknown"),

                  operationData("Patient",
                      patientModel == null?"Unknown": "${patientModel!.FName} ${patientModel!.LName}"
                  ),

                  operationData("Date", widget.operationModel.time),
                  operationData(
                      "Duration", widget.operationModel.duration.toString()),
                  operationData(
                      "Cost", "${widget.operationModel.cost.toString()} LE"),
                  Center(
                    child: OutlinedButton(
                      onPressed: () {
                        if(patientModel != null){
                          Services.pushPage(context, PatientPage(patientModel:patientModel!,),);
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.all(20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15), // <-- Radius
                        ),
                      ),
                      child: const Text(
                        "View Patient Page",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
