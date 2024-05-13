import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:takhleekish/Artist/Dashboard/artistDashboard.dart';
import 'package:takhleekish/Artist/sessionDatabase/artistSessionController.dart';
import 'package:takhleekish/Artist/sessionDatabase/artistSessionModel.dart';

import '../../../../../User/credentialsFile/user_model.dart';
import '../../../../../User/credentialsFile/user_repository.dart';


class PaintingSessionPage extends StatefulWidget {
  @override
  _PaintingSessionPageState createState() => _PaintingSessionPageState();
}
class _PaintingSessionPageState extends State<PaintingSessionPage> {
  final formkey=GlobalKey<FormState>();
  final userRepo=Get.put(User_repo());
  List<dynamic> dynamicEmailArray = [];
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    double screenWidhth = MediaQuery
        .of(context)
        .size
        .width;
    final controller=Get.put(ArtistSessionController());
    return Scaffold(

        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 880,
                child: Image.asset("assests/images/dbpic2.jpeg"
                  ,fit: BoxFit.fitHeight,),
                //add background image here
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),

                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                          width: 280,
                          height: 280,
                          child: Image.asset("assests/images/homeScreenPic.png")),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Container(
                              width: 300,
                              height: 50,
                              child: TextFormField(
                                controller: controller.artTitle,
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value!.isEmpty ||
                                      !RegExp(r'([a-zA-Z0-9_\s]+)').hasMatch(value!)) {
                                    return 'Enter correct title';
                                  }
                                  else {
                                    controller.artTitle.text=value;
                                  }
                                },
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                        width: 2,
                                        color: Color(0xfff77062),
                                      )

                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      )
                                  ),
                                  prefixIcon: Icon(Icons.article),
                                  label:Text("Session Title") ,
                                ),

                              ),
                            ),

                            SizedBox(
                              height: screenHeight * 0.02,
                            ),
                            Container(
                              width: 300,
                              height: 50,
                              child: TextFormField(
                                controller: controller.artistMail,
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if(value!.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}').hasMatch(value!))
                                  {
                                    return 'Enter correct Email';
                                  }
                                  else {
                                    controller.artistMail.text = value;
                                  }
                                },
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                        width: 2,
                                        color: Color(0xfff77062),
                                      )

                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      )
                                  ),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(left: 12.0,top: 10.0),
                                    child: Container(child: FaIcon(FontAwesomeIcons.idBadge,color: Colors.black,)),
                                  ),
                                  label:Text("Enter Artist Email") ,
                                ),

                              ),
                            ),
                            SizedBox(height: screenHeight*0.02),
                            Row(
                              children: [
                                SizedBox(width: screenWidhth*0.05,),
                                Text("Date",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                                SizedBox(width: screenWidhth*0.3,),
                                Column(
                                  children: [
                                    Container(
                                      width: 120,
                                      height: 40,
                                      child:Container(
                                        width: double.infinity,
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed:()async{
                                            final startDate=await pickDate();
                                            if(startDate==null) {
                                              Get.snackbar("Oops", "Session Date is required",
                                                  snackPosition:SnackPosition.BOTTOM,
                                                  backgroundColor: Colors.red.withOpacity(0.1),
                                                  colorText: Colors.red);
                                            }
                                            setState(() {
                                              controller.sessionDate=startDate;
                                            });
                                          },
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
                                                child:
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width:10,
                                                    ),
                                                    Icon(Icons.calendar_month,color: Colors.white,),
                                                    SizedBox(
                                                      width:5,
                                                    ),
                                                    Text("Date",style: TextStyle(color: Colors.white,fontSize: 20),),
                                                  ],
                                                )                                     ),
                                          ),
                                        ),
                                      ),

                                    ),



                                  ],
                                ),
                              ],
                            ),

                            SizedBox(height: screenHeight*0.005),
                            Row(
                              children: [
                                SizedBox(width: screenWidhth*0.05,),
                                Text("${controller.sessionDate?.day??''}/${controller.sessionDate?.month??''}/${controller.sessionDate?.year??''}"),
                                SizedBox(width: 85,),
                              ],
                            ),
                            SizedBox(height: 15),
                            Row(children: [
                              SizedBox(width: screenWidhth*0.05,),
                              Text("Time",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),

                              SizedBox(width: screenWidhth*0.285,),

                              Container(
                                width: 120,
                                height: 40,
                                child:Container(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed:()async{
                                      final startTime=await pickTime();
                                      if(startTime==null) {
                                        Get.snackbar("Oops", "Starting time is required",
                                            snackPosition:SnackPosition.BOTTOM,
                                            backgroundColor: Colors.red.withOpacity(0.1),
                                            colorText: Colors.red);
                                      }
                                      setState(() {
                                        controller.session_startingTime=startTime;
                                      });
                                    },
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
                                          child:
                                          Row(
                                            children: [
                                              SizedBox(
                                                width:10,
                                              ),
                                              Icon(Icons.access_time,color: Colors.white,),
                                              SizedBox(
                                                width:5,
                                              ),
                                              Text("Time",style: TextStyle(color: Colors.white,fontSize: 20),),
                                            ],
                                          )                                      ),
                                    ),
                                  ),
                                ),

                              ),


                            ],),
                            SizedBox(height: screenHeight*0.005),

                            Row(children: [
                              SizedBox(width: screenWidhth*0.05,),
                              Text("${controller.session_startingTime?.hourOfPeriod??''}:${controller.session_startingTime?.minute??''} ${controller.session_startingTime?.period == DayPeriod.am ? 'AM' : 'PM'}"),
                            ],)

                          ],
                        ),
                      ),

                      SizedBox(height: 20),
                      Container(
                        width: 300,
                        height: 40,
                        child:Container(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed:(){
                              if (formkey.currentState!.validate()){
                                final session = ArtistSessionModel(
                                    Title:controller.artTitle.text.trim(),
                                    artistEmail: controller.artistMail.text.trim(),
                                    startingTime: controller.session_startingTime.toString().trim(),
                                    sessionDate: controller.sessionDate.toString().trim(), checkReqStatus: 'false', Status: 'pending'
                                );
                                ArtistSessionController.instance.createSession(
                                    session);

                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => ArtistDashboard()),);
                                controller.artTitle.clear();
                                controller.artistMail.clear();
                                controller.sessionDate = null;
                                controller.session_startingTime = null;
                              }
                              else{
                                Get.snackbar("OOpS", "Session request has not been send",
                                    snackPosition:SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red.withOpacity(0.1),
                                    colorText: Colors.red);
                              }
                            },
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
                                child:
                                Text('Post Session',style: TextStyle(color: Colors.white,fontSize: 20)),
                              ),
                            ),
                          ),
                        ),

                      ),


                    ],
                  ),
                ),
              ),
            ],
          ),
        )

    );
  }
  Future<DateTime?> pickDate()=>showDatePicker(context: context, firstDate: DateTime.now(),initialDate: DateTime.now(), lastDate: DateTime(2100));
  Future<TimeOfDay?> pickTime()=>showTimePicker(context: context, initialTime: TimeOfDay.now());

  Future<List<User_model>> getAlluserData() async {
    return await userRepo.getAllUserDetail();
  }
  sendmail(String mail,String title) async {
    String username = 'ghazih808@gmail.com';
    String password = 'kfia mddb tbcs yyci';

    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address('takhleeqish@gmail.com', 'Takhleeqish')
      ..recipients.add(mail)
    // ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
    // ..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = 'Takhleeqish! Artist Session '
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h1>Scheduled Session.</h1>\n<p>Hey! An amazing session on $title to learn and enhance skills has been scheduled. Go check it out!.</p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}