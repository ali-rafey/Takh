import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

import '../adminDashboard/dashboard.dart';

class ComplainDetails extends StatefulWidget
{
  final String url;
  final String complainant;
  final String complain;

  ComplainDetails(this.url, this.complainant, this.complain);

  @override
  State<ComplainDetails> createState() => _ComplainDetailsState();
}

class _ComplainDetailsState extends State<ComplainDetails> {
  @override
  Widget build(BuildContext context) {
    double screenHeight=MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xffF0A2C9),
                Color(0xffD2A5D0),
                Color(0xff6F9BB4),
              ],
            ),
          ),
          child:Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 50),
                Center(

                  child: Container(
                    width: 200,
                    height: 200,
                    child: CircleAvatar(
                      child: ClipOval(

                        child: Image.network(widget.url),
                      ),
                    ),


                  ),
                ),
                SizedBox(height: 50),

                Center(child: Text("Complainant :",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
                SizedBox(height: 10),
                Center(child: Text("${widget.complainant}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)),
                SizedBox(height: 30),

                Center(child: Text("Complain :",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
                SizedBox(height: 10),
                Center(child: Text("${widget.complain}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),)),
                SizedBox(height: 50),
                Container(
                  width: 200,
                  height: 50,
                  child:Container(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed:()   {
                        sendmail(widget.complainant);
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => AdminDashboard()),);
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
                          child:  Text('Action',style:TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold)),
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
    );
  }
  sendmail(String mail) async {
    String username = 'ghazih808@gmail.com';
    String password = 'kfia mddb tbcs yyci';

    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address('takhleeqish@gmail.com', 'Takhleeqish')
      ..recipients.add(mail)
    // ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
    // ..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = 'Takhleeqish! Complain Request'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h1>Your Complain has been viewed.</h1>\n<p>Hey! Sorry for inconvenience, Our team will reach you soon. .</p>";

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