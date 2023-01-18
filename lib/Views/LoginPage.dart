import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:surgery/Model/OperationModel.dart';
import 'package:surgery/Services/EmployeeServices.dart';
import 'package:surgery/Views/AdminPage.dart';
import 'package:surgery/Views/Components/login_background.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:surgery/Views/DoctorPage.dart';
import 'package:surgery/Model/DoctorModel.dart';
import 'package:surgery/Services/AuthServices.dart';
import 'package:surgery/Services/DoctorServices.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool showPassword = false;
  bool isLoading = true;
  FocusNode passNode = FocusNode();

  login(context) async {
    if (username.text != "" && pass.text != "") {
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
      Map<String,int> x = await Services.login(username.text, pass.text);
      Services.popPage(context);
      if (x['type']! > 0) {
        if(x['type']! == 1){
          Services.doctorModel = await DoctorServices.getByUsername(username.text, pass.text);
          if (Services.doctorModel != null) {
            Services.doctorModel?.usernameID = x['ID']!;
            Services.pushReplacementPage(context,const DoctorPage());
          }
        }
        else if(x['type']! == 2){
          Services.adminModel = await AdminServices.getByUsername(username.text, pass.text);
          if(Services.adminModel != null){
            Services.adminModel?.usernameID = x['ID']!;
            Services.pushReplacementPage(context,const AdminPage());
          }
        }
      } else {
        Services.showMessage(context, x['type'] == -1 ? "please enter correct username or password." : "please check internet connection.");
      }
    }
    else{
      Services.showMessage(context, "Please enter username and password!");
    }
  }

  var operations = [
    Operation(),
    Operation(),
    Operation(),
    Operation(),
    Operation(),
    Operation(),
    Operation(),
    Operation(),
  ];

  @override
  void dispose() {
    username.dispose();
    pass.dispose();
    passNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "LOGIN",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w800,
                  fontSize: 50,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SvgPicture.asset(
                "assets/images/login.svg",
                width: w * 0.8,
                fit: BoxFit.scaleDown,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 15),
                child: SizedBox(
                  width: w * 0.8,
                  child: TextField(
                    controller: username,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(80)),
                      prefixIcon: const Icon(Icons.email_outlined),
                      hintText: "Email",
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SizedBox(
                  width: w * 0.8,
                  child: TextField(
                    controller: pass,
                    focusNode: passNode,
                    obscureText: !showPassword,
                    enableSuggestions: false,
                    autocorrect: false,
                    onEditingComplete: () {
                      setState(() {
                        showPassword = false;
                      });
                    },
                    onSubmitted: (term) {
                      setState(() {
                        passNode.unfocus();
                        showPassword = false;
                        login(context);
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(80)),
                      prefixIcon: const Icon(Icons.key),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        child: Icon(!showPassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      hintText: "Password",
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await login(context);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 17, horizontal: 70),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
