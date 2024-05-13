import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takhleekish/User/credentialsFile/user_repository.dart';
import 'package:takhleekish/User/dashboard/User_Dashboard.dart';
import 'package:takhleekish/User/throughNavBar/complainsPage/complainDatabase/complainController.dart';
import 'package:takhleekish/User/throughNavBar/complainsPage/complainDatabase/complainModel.dart';
import 'package:takhleekish/User/throughNavBar/complainsPage/complainDatabase/complainRepository.dart';

import '../../../Artist/artistPersonal/artist_authentication.dart';
import '../../credentialsFile/user_model.dart';

class ComplaintsPage extends StatefulWidget {
  @override
  _ComplaintsPageState createState() => _ComplaintsPageState();
}

class _ComplaintsPageState extends State<ComplaintsPage> {

  final formkey=GlobalKey<FormState>();
  final complainrepo=Get.put(ComplainRepo());
  final authrepo = Get.put(Artist_Auth());

  final userRepo = Get.put(User_repo());
  String email="";
  String url="";
  @override
  Widget build(BuildContext context) {
    final controller=Get.put(ComplainController());

    return Scaffold(
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              email=snapshot.data!.email;
              url=snapshot.data!.url;
              return SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 880,
                      child: Image.asset("assests/images/dbpic2.jpeg"
                        ,fit: BoxFit.fitHeight,),
                      //add background image here
                    ),
                    Center(
                      child: Form(
                        key: formkey,
                        child: Container(
                          padding: EdgeInsets.all(16.0),
                          constraints: BoxConstraints(maxWidth: 400),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 200,),
                              Text(
                                'We apologize for any inconvenience!',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 20),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.blue, // Change border color to red for complaints
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: TextFormField(
                                  controller: controller.Complain,
                                  keyboardType: TextInputType.name,
                                  validator: (value) {
                                    if (value!.isEmpty)
                                    {
                                      return 'Enter Complain';
                                    }
                                    else {
                                      controller.Complain.text = value;
                                    }},
                                  maxLines: 5,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(8.0),
                                    hintText: 'Enter your complaint here',
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                width: 200,
                                height: 50,
                                child:Container(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed:()   {
                                      if (formkey.currentState!.validate()){

                                        final complain=ComplainModel(
                                            complain: controller.Complain.text.trim(),
                                            userEmail: email, url: url) ;
                                        ComplainController.instance.createComplain(complain);
                                        Get.snackbar("Congratulations", "Complain registered successfully",
                                            snackPosition:SnackPosition.BOTTOM,
                                            backgroundColor: Colors.pink.withOpacity(0.5),
                                            colorText: Colors.black);

                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context) => User_dashboard()),);
                                        controller.Complain.clear();

                                      }

                                    }  ,
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                    ),
                                    child: Ink(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [Color(0xffA770EF), Color(0xffCF8BF3), Color(0xffFDB99B)],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      child: Container(
                                        alignment: Alignment.center,
                                        child:  Text('Submit Complaint',style:TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ),
                                ),

                              )


                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text('User not found');
            } else {
              return Text('Something went wrong');
            }
          }
          else {
            // Return Center widget to display CircularProgressIndicator in the center
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),

    );
  }
  Future<User_model?> getData() async {
    final email = authrepo.firebaseUser.value?.email;
    if (email != null) {
      return await userRepo.getUserDetail(email);
    }
    return null; // Handle the case where email is null
  }
  @override
  void dispose() {
    super.dispose();
  }
}