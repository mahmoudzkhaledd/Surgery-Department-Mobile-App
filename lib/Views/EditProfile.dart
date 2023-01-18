import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:surgery/Model/DoctorModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:surgery/Services/AuthServices.dart';
import 'package:surgery/Services/DoctorServices.dart';
import 'package:path_provider/path_provider.dart';

class EditDocProfile extends StatefulWidget {
  const EditDocProfile({Key? key}) : super(key: key);

  @override
  State<EditDocProfile> createState() => _EditDocProfileState();
}

class _EditDocProfileState extends State<EditDocProfile> {
  late Map<String, dynamic> propList;
  File? image = null;
  late Image finalImage;

  @override
  void initState() {

    propList = <String, dynamic>{
      'Username':  Services.doctorModel!.username,
      'Password':  Services.doctorModel!.password,
      'First Name':  Services.doctorModel!.Fname,
      'Middle Name':  Services.doctorModel!.Mname,
      'Last Name':  Services.doctorModel!.Lname,
      'Email':  Services.doctorModel!.Email,
      'Gender':  Services.doctorModel!.gender,
      'Birth Date':  Services.doctorModel!.BirthDate,
      'City':  Services.doctorModel!.city,
      'Street':  Services.doctorModel!.street,
      'Building':  Services.doctorModel!.building,
      'Phone 1':  Services.doctorModel!.phone_1,
      'Phone 2':  Services.doctorModel!.phone_2,
      'Speciality':  Services.doctorModel!.speciality,
      'SSN':  Services.doctorModel!.SSN
    };
    propList['Username'] = Services.doctorModel!.username;
    propList['Password'] = Services.doctorModel!.password;
    propList['First Name'] = Services.doctorModel!.Fname;
    propList['Middle Name'] = Services.doctorModel!.Mname;
    propList['Last Name'] = Services.doctorModel!.Lname;
    propList['Email'] = Services.doctorModel!.Email;
    propList['Gender'] = Services.doctorModel!.gender;
    propList['Birth Date'] = Services.doctorModel!.BirthDate;
    propList['City'] = Services.doctorModel!.city;
    propList['Street'] = Services.doctorModel!.street;
    propList['Building'] = Services.doctorModel!.building;
    propList['Phone 1'] = Services.doctorModel!.phone_1;
    propList['Phone 2'] = Services.doctorModel!.phone_2;
    propList['Speciality'] = Services.doctorModel!.speciality;
    propList['SSN'] = Services.doctorModel!.SSN;



    super.initState();
  }

  browseImage() async {
    XFile? fp = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (fp != null) {
      setState(() {
        image = File(fp.path);
      });
    }
  }

  void save() async {
    for (int i = 0; i < propList.length; i++) {
      if (propList.entries.elementAt(i).value == "") {
        Services.showMessage(context, "Please Enter the full data.");
        return;
      }
    }
    await DoctorServices.updateData(propList, image);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () => save(),
              child: const Icon(Icons.check),
            ),
          ),
        ],
        title: const Text(
          "Edit Your Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 20,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: image == null ? null : FileImage(image!),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => browseImage(),
                      child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.edit),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              for (int i = 0; i < propList.length; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextFormField(
                    maxLength: 199,
                    initialValue: propList.entries.elementAt(i).value,
                    onChanged: (String? x){
                      propList[propList.entries.elementAt(i).key] = x ?? "";
                    },
                    decoration: InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      contentPadding:
                      const EdgeInsets.symmetric(vertical: 22, horizontal: 10),
                      hintText: propList.entries.elementAt(i).key,
                      label: Text(propList.entries.elementAt(i).key),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: Color(0xfff3f3f4)),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      fillColor: const Color(0xfff3f3f4),
                      filled: true,
                    ),
                  )
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextEdit extends StatelessWidget {
  TextEdit({Key? key, required this.hint,required this.controller,this.numbers})
      : super(key: key);
  final String hint;
  final TextEditingController controller;
  bool? numbers = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: TextFormField(
        maxLength: 199,
        controller: controller,
        keyboardType: numbers!? TextInputType.number:TextInputType.text,
        inputFormatters: numbers!?[
          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
        ]:null,
        decoration: InputDecoration(
          counterText: '',

          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 22, horizontal: 10),
          labelText: hint,
          hintText: hint,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Color(0xfff3f3f4)),
            borderRadius: BorderRadius.circular(10.0),
          ),
          fillColor: const Color(0xfff3f3f4),
          filled: true,
        ),
      ),
    );
  }
}
