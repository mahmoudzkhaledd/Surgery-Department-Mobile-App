import 'package:flutter/material.dart';
import 'package:surgery/Services/DoctorServices.dart';
import 'package:surgery/Services/EmployeeServices.dart';

import '../Model/DoctorModel.dart';
import '../Services/AuthServices.dart';
import 'DoctorProfile.dart';

class ViewAllDoctors extends StatefulWidget {
  const ViewAllDoctors({Key? key}) : super(key: key);

  @override
  State<ViewAllDoctors> createState() => _ViewAllDoctorsState();
}

class _ViewAllDoctorsState extends State<ViewAllDoctors> {
  List<Doctor> docList = [];
  Future<void> loadAllDoctors()async{
    docList.clear();
    var l = await DoctorServices.getAllDocs();
    for (Map<String, dynamic> i in l) {
      docList.add(Doctor.getModel(i)..usernameID = int.parse(i['ID'].toString()));
    }
    setState(() {});
  }
  deleteDoctor(int code,int usernameID)async{
    await AdminServices.deleteDoctor(code,usernameID);
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
          "All Doctors",
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
            itemCount: docList.length,
            itemBuilder: (ctx,index) {
              return DoctorCard(
                doctorModel: docList[index],
                onTap: (){
                  deleteDoctor(docList[index].code,docList[index].usernameID);
                },
                width: w,
              );
            },
          ),
        ),
      ),
    );
  }
}
class DoctorCard extends StatelessWidget {
  DoctorCard({Key? key,required this.doctorModel,required this.width,required this.onTap}) : super(key: key);
  final VoidCallback onTap;
  final Doctor doctorModel;
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
              CircleAvatar(
                radius: 30,
                backgroundImage: (doctorModel.imageLoc == "" || doctorModel.imageLoc == "null")
                    ? null
                    : NetworkImage(doctorModel.imageLoc),
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
                      "${doctorModel.Fname} ${doctorModel.Lname}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.4,
                    child: Text(
                      doctorModel.Email,
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
                    context,
                    DoctorProfile(
                      canEdit: false,
                      doctorModel: doctorModel,
                    ),
                  );
                },
                child: const Icon(Icons.person),
              ),
              const SizedBox(width: 13),
              GestureDetector(
                onTap: onTap,
                child: const Icon(Icons.close),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

