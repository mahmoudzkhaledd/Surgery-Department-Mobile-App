import 'package:flutter/material.dart';
import 'package:surgery/Model/DoctorModel.dart';
import 'package:surgery/Services/AuthServices.dart';
import 'package:surgery/Services/DoctorServices.dart';
import 'package:surgery/Views/EditProfile.dart';

class DoctorProfile extends StatefulWidget {
  DoctorProfile({
    Key? key,
    required this.canEdit,
    required this.doctorModel,
  }) : super(key: key);
  Doctor doctorModel;
  final bool canEdit;

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Your Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            widget.doctorModel = await DoctorServices.getByUsername(widget.doctorModel.username, widget.doctorModel.password);
            setState(() {});
          },
          child: ListView(
            padding: const EdgeInsets.all(15),
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 20,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 65,
                      backgroundImage:
                          NetworkImage(widget.doctorModel!.imageLoc),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.doctorModel!.Fname} ${widget.doctorModel!.Lname}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.doctorModel!.phone_1,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        widget.doctorModel!.Email,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      widget.canEdit
                          ? GestureDetector(
                              onTap: () {
                                Services.pushPage(
                                    context, const EditDocProfile());
                              },
                              child: const Text(
                                "Edit Profile",
                                style: TextStyle(color: Colors.blueAccent),
                              ),
                            )
                          : const SizedBox(
                              width: 0,
                              height: 0,
                            ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        child: Text(
                          "${widget.doctorModel!.rank}%",
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text("Rank", style: TextStyle(fontSize: 18)),
                    ],
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        child: Text(
                          widget.doctorModel.points.toString(),
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text("Points", style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      DoctorProperties(
                        color: const Color.fromARGB(255, 216, 244, 255),
                        title: "Success Operations",
                        precentage: widget.doctorModel.successOperations,
                        description:
                            "forward or onward movement toward a destination move forward or onward in space or time.",
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      DoctorProperties(
                        color: const Color.fromARGB(255, 255, 227, 216),
                        title: "Day Attend",
                        precentage: widget.doctorModel.dayAttend,
                        description:
                            "forward or onward movement toward a destination move forward or onward in space or time.",
                      ),
                    ],
                  ),
                  Row(
                    children: [
                       DoctorProperties(
                        color:const Color.fromARGB(255, 255, 227, 216),
                        title: "Taken Number",
                        precentage: widget.doctorModel.takenNumber,
                        description:
                            "forward or onward movement toward a destination move forward or onward in space or time.",
                      ),
                      const  SizedBox(
                        width: 20,
                      ),
                      DoctorProperties(
                        color:const Color.fromARGB(255, 216, 244, 255),
                        title: "Grade",
                        precentage: widget.doctorModel.grade,
                        description:
                            "forward or onward movement toward a destination move forward or onward in space or time.",
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DoctorProperties extends StatelessWidget {
  const DoctorProperties({
    Key? key,
    required this.precentage,
    required this.title,
    required this.description,
    required this.color,
  }) : super(key: key);
  final Color color;
  final int precentage;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Flexible(
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(bottom: 20),
        height: (w - 45) / 2,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            const SizedBox(
              height: 10,
            ),
            LinearProgressIndicator(
              color: const Color.fromARGB(255, 248, 244, 242),
              valueColor: const AlwaysStoppedAnimation<Color>(
                  Color.fromARGB(255, 85, 77, 252)),
              value: precentage * 0.01,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              description,
              textAlign: TextAlign.start,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
