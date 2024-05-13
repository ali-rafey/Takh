import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:takhleekish/Artist/throughDashboard/postArtifact/postArtifacts.dart';



class OtpPage extends StatefulWidget{

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final formkey = GlobalKey<FormState>();
  EmailOTP myAuth = EmailOTP();
  TextEditingController UsOtp = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body:  Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                children: [

                  FaIcon(
                    FontAwesomeIcons.key,
                    size: 90,
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Text(
                    "Verify OTP",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Text(
                    "Enter your OTP here ",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 80,
                  ),


                  Container(
                    width: 350,
                    height: 50,
                    child: TextFormField(
                      controller: UsOtp,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'OTP is Required';
                        } else {
                          UsOtp.text = value;
                        }
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              width: 2,
                              color: Color(0xfff77062),
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            )),
                        prefixIcon: Icon(
                          Icons.numbers_outlined,
                          color: Colors.black,
                        ),
                        label: Text("OTP"),
                        hintText: "Enter OTP",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: 300,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: ()async {

                          if (await myAuth.verifyOTP(otp:UsOtp.text) == true) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content:Text("OTP Verified"),
                                ));
                            // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ResetPasssword()));
                          }
                          else{
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content:Text("Invalid OTP"), ));

                          }


                      },
                      child: Text(
                        "Verify",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}