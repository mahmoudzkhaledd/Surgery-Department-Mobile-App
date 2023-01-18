import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:surgery/Services/AuthServices.dart';

class NoInternetPage extends StatefulWidget {
  const NoInternetPage({Key? key}) : super(key: key);

  @override
  State<NoInternetPage> createState() => _NoInternetPageState();
}

class _NoInternetPageState extends State<NoInternetPage> {
  tryAgain() async {

  }
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                 Padding(
                  padding:const EdgeInsets.symmetric(horizontal: 30),
                  child: Image(
                    image:const AssetImage(
                      'assets/images/No_Connection.png',
                    ),
                    width: (w<h)? w : w*0.4,
                  ),
                ),
                Text(
                  "Whoops!",
                  style: GoogleFonts.roboto(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 5,
                    bottom: 40,
                    right: 8,
                    left: 8,
                  ),
                  child: Text(
                    "It seems to be a problem with your Network Connection!",
                    style: GoogleFonts.roboto(fontSize: 20, color: Colors.blue),
                    textAlign: TextAlign.center,
                  ),
                ),
                GestureDetector(
                  onTap: ()=>tryAgain(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 70,vertical: 15),
                    margin:const EdgeInsets.only(bottom: 20) ,
                    child: const Text(
                      "Try Again",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
