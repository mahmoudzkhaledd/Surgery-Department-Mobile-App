import 'package:flutter/material.dart';
import 'package:surgery/Services/AuthServices.dart';
import 'package:surgery/Services/DoctorServices.dart';
import 'package:surgery/Services/EmployeeServices.dart';
import 'package:surgery/Views/DoctorProfile.dart';
import 'package:surgery/Views/EditProfile.dart';

import '../Model/DoctorModel.dart';

class SendMessagePage extends StatefulWidget {
  const SendMessagePage({Key? key}) : super(key: key);

  @override
  State<SendMessagePage> createState() => _SendMessagePageState();
}

class _SendMessagePageState extends State<SendMessagePage> {
  List<Doctor> docList = <Doctor>[];

  loadAllDocs() async {
    docList.clear();
    var l = await DoctorServices.getAllDocs();
    for (Map<String, dynamic> i in l) {
      docList.add(Doctor.getModel(i));
    }
    setState(() {});
  }

  @override
  void initState() {
    loadAllDocs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Send Message",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: docList
                .map(
                  (e) => DrawDoctor(
                    doctorModel: e,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

class DrawDoctor extends StatefulWidget {
  DrawDoctor({Key? key, required this.doctorModel}) : super(key: key);
  final Doctor doctorModel;

  @override
  State<DrawDoctor> createState() => _DrawDoctorState();
}

class _DrawDoctorState extends State<DrawDoctor> {
  double contHeight = 90;
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  String mess = "";
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 10,
        right: 20,
        left: 20,
      ),
      width: w - 20,
      height: contHeight,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 217, 220, 227),
        borderRadius: BorderRadius.circular(11),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: widget.doctorModel.imageLoc == ""
                          ? null
                          : NetworkImage(widget.doctorModel.imageLoc),
                    ),
                    const SizedBox(
                      width: 13,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: w * 0.4,
                          child: Text(
                            "${widget.doctorModel.Fname} ${widget.doctorModel.Lname}",
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          width: w * 0.4,
                          child: Text(
                            widget.doctorModel.Email,
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
                            doctorModel: widget.doctorModel!,
                          ),
                        );
                      },
                      child: const Icon(Icons.person),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        mess = "";
                        showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                          title: Text('Send Message To ${widget.doctorModel.Fname} ${widget.doctorModel.Lname}'),
                          content: SizedBox(
                            height: 200,
                            child: Column(
                              children: [
                                const Text('Enter Message'),
                                const SizedBox(height: 10,),
                                TextField(
                                  keyboardType: TextInputType.multiline,
                                  minLines: 1,
                                  maxLines: 5,
                                  onChanged: (e){
                                    mess = e;
                                  },
                                  decoration: InputDecoration(
                                    counterText: '',
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                    contentPadding:
                                    const EdgeInsets.symmetric(vertical: 22, horizontal: 10),
                                    labelText: 'Message',
                                    hintText: 'Message',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(width: 1, color: Color(0xfff3f3f4)),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    fillColor: const Color(0xfff3f3f4),
                                    filled: true,
                                  ),
                                ),
                                const SizedBox(height: 30,),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, 'Cancel');
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () async{
                                showDialog(
                                  context: context,
                                  builder: (c) => AlertDialog(
                                    title: const Text("Logging in"),
                                    content: Row(
                                      children: const [
                                        CircularProgressIndicator(),
                                        Text("     Loading"),
                                      ],
                                    ),
                                  ),
                                );
                                bool x = await AdminServices.sendNotification(widget.doctorModel.code, mess);
                                Services.popPage(context);
                                await Services.showMessage(context, x? "Sent!":"Failed");
                                Navigator.pop(context, 'OK');
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                        },
                      ).then((value) async{
                          if(value.toString() != "OK"){
                            Services.showMessage(context, "Please Enter a message!");
                          }
                        });
                      },
                      child: const Icon(
                        Icons.send,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
