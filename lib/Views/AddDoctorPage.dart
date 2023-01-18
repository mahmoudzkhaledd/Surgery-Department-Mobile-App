import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:surgery/Services/AuthServices.dart';
import 'package:surgery/Services/EmployeeServices.dart';
import 'EditProfile.dart';

class AddDoctorPage extends StatefulWidget {
  const AddDoctorPage({Key? key}) : super(key: key);

  @override
  State<AddDoctorPage> createState() => _AddDoctorPageState();
}

class _AddDoctorPageState extends State<AddDoctorPage> {
  final List<String> prop = [
    'Username',
    'Password',
    'First Name',
    'Middle Name',
    'Last Name',
    'Email',
    'City',
    'Street',
    'Building',
    'Phone 1',
    'Phone 2',
    'Speciality',
    'SSN',
    'Gender',
    'Salary',
    'Birth Date',
  ];
  List<TextEditingController> cont = [];

  @override
  void initState() {
    for (int i = 0; i < prop.length; i++) {
      cont.add(TextEditingController());
    }
    cont.last.text = DateFormat('yyyy-MM-DD').format(chosenDate);
    cont[13].text = "1";
    cont[14].text = "0";
    super.initState();
  }

  DateTime chosenDate = DateTime.now();

  @override
  void dispose() {
    for (TextEditingController i in cont) {
      i.dispose();
    }
    super.dispose();
  }
  Future<void> refresh()async{
    for(int i=0;i<cont.length -3;i++){
      cont[i].text = "";
    }
    setState(() {});
  }


  addDoctor() async {
    Map<String,String> mp = {};
    for(int i=0;i<cont.length;i++){
      if(cont[i].text == ""){
        mp.clear();
        Services.showMessage(context, "Please Fill All Fields!");
        return;
      }
      mp.addAll({
        prop[i].toLowerCase().replaceAll(' ', '') :cont[i].text
      });
    }
    mp.addAll({"image":""});
    bool x = await AdminServices.addDoctor(mp);
    if(x){refresh();}
    Services.showMessage(context, x ? "Done!":"Failed.");
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
          IconButton(onPressed: addDoctor, icon: const Icon(Icons.check))
        ],
        title: const Text(
          "Hire new doctor",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: refresh,
          child: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemBuilder: (BuildContext context, int i) {
              bool date = (prop[i] == 'Birth Date');
              bool salary = (prop[i] == 'Salary');
              bool gender = (prop[i] == 'Gender');
              bool str = (!date && !gender);

              cont.last.text = DateFormat('yyyy-MM-DD').format(chosenDate);
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: str
                    ? TextEdit(
                        hint: prop[i],
                        controller: cont[i],
                        numbers: salary,
                      ) : date ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(cont.last.text),
                              ElevatedButton(
                                onPressed: () async {
                                  DateTime? dd = await showDatePicker(
                                    context: context,
                                    initialDate: chosenDate,
                                    firstDate: DateTime(1950),
                                    lastDate: DateTime(DateTime.now().year + 5),
                                  );
                                  chosenDate = dd ?? chosenDate;
                                  cont.last.text = DateFormat('yyyy-MM-DD').format(chosenDate);
                                  setState(() {});
                                },
                                child: const Text("Birthdate"),
                              ),
                            ],
                          ) : DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              counterText: '',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 22, horizontal: 10),
                              hintText: 'Gender',
                              labelText: 'Gender',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: Color(0xfff3f3f4)),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              fillColor: const Color(0xfff3f3f4),
                              filled: true,
                            ),
                            items: const [
                              DropdownMenuItem<String>(
                                value: '1',
                                child: Text('Male'),
                              ),
                              DropdownMenuItem<String>(
                                value: '0',
                                child: Text('Female'),
                              ),
                            ],
                            value: cont[13].text,
                            onChanged: (s) {
                              cont[13].text = s ?? "Male";
                              setState(() {});
                            },
                          ),
              );
            },
            itemCount: prop.length,
          ),
        ),
      ),
    );
  }
}
