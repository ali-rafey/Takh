import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:email_auth/email_auth.dart';
import 'package:get/get.dart';
import 'package:takhleekish/User/forgot_Password/resetPassword.dart';
import '../userPersonal/user_login.dart';

class Forgot_Page extends StatefulWidget {
  @override
  State<Forgot_Page> createState() => _Forgot_PageState();
}

class _Forgot_PageState extends State<Forgot_Page> {
  final formkey = GlobalKey<FormState>();
  EmailOTP myAuth = EmailOTP();
  final auth=FirebaseAuth.instance;
  TextEditingController Usemail = TextEditingController();
  TextEditingController UsOtp = TextEditingController();
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  SizedBox(
                    height: 120,
                  ),
                  FaIcon(
                    FontAwesomeIcons.key,
                    size: 90,
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Text(
                    "Forget Password",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Text(
                    "Verify your Email here ",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Container(
                    width: 350,
                    height: 50,
                    child: TextFormField(
                      controller: Usemail,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}')
                                .hasMatch(value!)) {
                          return 'Enter correct Email';
                        } else {
                          Usemail.text = value;
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
                          Icons.mail,
                          color: Colors.black,
                        ),
                        label: Text("Email"),
                        hintText: "Enter Email here",

                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Container(
                    width: 300,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: ()async {
                             if(formkey.currentState!.validate())
                               {
                                 await auth.sendPasswordResetEmail(email: Usemail.text).then((value){
                                   ScaffoldMessenger.of(context).showSnackBar(
                                       const SnackBar(content:Text("Email has been sent to your gmail account"), ));
                                   Get.offAll(()=>User_login());

                                 });

                                 }
                                 else{
                                   ScaffoldMessenger.of(context).showSnackBar(
                                       const SnackBar(content:Text("Enter correct Email"), ));

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
