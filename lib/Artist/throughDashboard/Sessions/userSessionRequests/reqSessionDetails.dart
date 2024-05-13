import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:takhleekish/Artist/throughDashboard/Sessions/userSessionRequests/userRequestPage.dart';
import 'package:takhleekish/Artist/Dashboard/artistDashboard.dart';

class ReqSessionDetailPage extends StatefulWidget{
  final String UserEmail;
  final String title;
  final String id;
  final DateTime date;
  final TimeOfDay sessionTime;
  ReqSessionDetailPage(
      this.UserEmail,this.title,this.sessionTime,this.date,{required this.id});

  @override
  State<ReqSessionDetailPage> createState() => _ReqSessionDetailPageState();
}

class _ReqSessionDetailPageState extends State<ReqSessionDetailPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight=MediaQuery.of(context).size.height;
    double screenWidth=MediaQuery.of(context).size.width;
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
            Center(
              child: Container(
                child: Column(
                  children: [
                    SizedBox(height: screenHeight*0.01,),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0.0),
                      child: Container(
                          width: 280,
                          height: 280,
                          child: Image.asset("assests/images/homeScreenPic.png")),
                    ),
                    SizedBox(
                      height:screenHeight*0.04,
                    ),
                    Text("Session Title",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Text("${widget.title}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
                    SizedBox(
                      height:screenHeight*0.02,
                    ),
                    Text("User Email",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Text(" ${widget.UserEmail}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),

                    SizedBox(
                      height:screenHeight*0.02,
                    ),
                    Text("Date",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Text("${widget.date.month}/${widget.date.day}/${widget.date.year}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),

                    SizedBox(
                      height:screenHeight*0.02,
                    ),
                    Text("Session Time",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Text("${_formatTime(widget.sessionTime)}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),                    SizedBox(
                      height:screenHeight*0.02,
                    ),
                    SizedBox(
                      height:screenHeight*0.02,
                    ),
                    Container(
                      width: screenWidth*0.3,
                      height: screenHeight*0.05,
                      child: Center(
                        child: ElevatedButton(onPressed:()  async {

                          await FirebaseFirestore.instance.collection("user_Session").doc(widget.id)
                              .update(
                              {
                                'Status':"approved",
                                'CheckReqStatus':"true"
                              }
                          ).whenComplete(() {
                            Get.snackbar("Congratulations", "Session request has been Approved.",
                                snackPosition:SnackPosition.BOTTOM,
                                backgroundColor: Colors.green.withOpacity(0.1),
                                colorText: Colors.white);
                            approveSendmail(widget.UserEmail, widget.title);
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>UserRequestPage()));

                          }

                          ).catchError((error,stackTrace){
                            Get.snackbar("Error", "Something went wrong. Try again",
                                snackPosition:SnackPosition.BOTTOM,
                                backgroundColor: Colors.redAccent.withOpacity(0.1),
                                colorText: Colors.red);
                            print(error.toString());});
                        }, child:Center(child: Center(child: FaIcon(FontAwesomeIcons.check,color: Colors.white,))),

                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)
                              )
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height:screenHeight*0.02,
                    ),
                    Container(
                      width: screenWidth*0.3,
                      height: screenHeight*0.05,
                      child: Center(
                        child: ElevatedButton(onPressed:()  async {

                          await FirebaseFirestore.instance.collection("user_Session").doc(widget.id)
                              .update(
                              {
                                'Status':"rejected",
                                'CheckReqStatus':"true"
                              }
                          ).whenComplete(() {
                            Get.snackbar("Congratulations", "Session request has been rejected.",
                                snackPosition:SnackPosition.BOTTOM,
                                backgroundColor: Colors.green.withOpacity(0.1),
                                colorText: Colors.white);
                            rejectedSendmail(widget.UserEmail, widget.title);
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>UserRequestPage()));

                          }

                          ).catchError((error,stackTrace){
                            Get.snackbar("Error", "Something went wrong. Try again",
                                snackPosition:SnackPosition.BOTTOM,
                                backgroundColor: Colors.redAccent.withOpacity(0.1),
                                colorText: Colors.red);
                            print(error.toString());});
                        }, child:Center(child: Center(child: FaIcon(FontAwesomeIcons.x,color: Colors.white,))),

                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)
                              )
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  String _formatTime(TimeOfDay timeOfDay) {
    // Convert 24-hour format to 12-hour format
    int hour = timeOfDay.hourOfPeriod;
    int minute = timeOfDay.minute;
    String period = timeOfDay.period == DayPeriod.am ? 'AM' : 'PM';

    // Format the time as HH:MM AM/PM
    return '${_formatHour(hour)}:${_formatMinute(minute)} $period';
  }

  String _formatHour(int hour) {
    // Ensure hour is in 12-hour format
    if (hour == 0) {
      return '12'; // 0 is 12 AM in 12-hour format
    } else if (hour > 12) {
      return '${hour - 12}';
    } else {
      return '$hour';
    }
  }

  String _formatMinute(int minute) {
    // Add leading zero if minute is less than 10
    return minute < 10 ? '0$minute' : '$minute';
  }
  approveSendmail(String mail,String demo) async {
    String username = 'ghazih808@gmail.com';
    String password = 'kfia mddb tbcs yyci';

    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address('takhleeqish@gmail.com', 'Takhleeqish')
      ..recipients.add(mail)
    // ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
    // ..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = 'Takhleeqish! Session Request Status'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h1>Approved.</h1>\n<p>Hey! your request for $demo session has been approved.</p>";

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
  rejectedSendmail(String mail,String demo) async {
    String username = 'ghazih808@gmail.com';
    String password = 'kfia mddb tbcs yyci';

    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address('takhleeqish@gmail.com', 'Takhleeqish')
      ..recipients.add(mail)
    // ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
    // ..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = 'Takhleeqish! Session Request Status'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h1>Rejected.</h1>\n<p>Hey! your request for $demo session has been rejected.</p>";

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