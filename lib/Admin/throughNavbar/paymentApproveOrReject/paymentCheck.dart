import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:takhleekish/Admin/throughNavbar/paymentApproveOrReject/approveOrRejectPayment.dart';
import 'package:takhleekish/User/payments/database/controller/controller.dart';
import 'package:takhleekish/User/payments/database/model/model.dart';
import 'package:takhleekish/User/payments/database/repository/Repository.dart';
import '../../../Artist/artistPersonal/artist_authentication.dart';
import '../../../Artist/controllers/artist_controller.dart';
import '../../../User/credentialsFile/user_model.dart';
import '../../../User/credentialsFile/user_repository.dart';
import '../../adminDashboard/dashboard.dart';

class PaymentCheck extends StatelessWidget
{
  final controller = Get.put(Artist_Controller());
final authrepo = Get.put(Artist_Auth());
final paymentRepo=Get.put(Payment_repo());
final userRepo=Get.put(User_repo());
late final String stime;
late final String etime;
List<dynamic> dynamicEmailArray = [];

final FirebaseAuth _auth=FirebaseAuth.instance;
@override
Widget build(BuildContext context){
  return Scaffold(
    body: FutureBuilder(
      future: getAlluserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            var totalEmails=snapshot.data!.length;

            for(int i=0;i<snapshot.data!.length;i++)
            {
              dynamicEmailArray.add(snapshot.data![i].email);
            }

            return FutureBuilder(
              future: getAllData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    print(snapshot.data!.length);
                    return Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 880,
                          child: Image.asset("assests/images/dbpic2.jpeg"
                            ,fit: BoxFit.fitHeight,),
                          //add background image here
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.separated(
                                  itemCount: snapshot.data!.length, // Number of exhibitions (fetch from the database)
                                  itemBuilder: (context, index) {
                                    if(snapshot.data![index].paymentCheck=="false")
                                    {
                                      return Slidable(
                                        actionPane: SlidableDrawerActionPane(),
                                        actionExtentRatio: 0.25,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(15.0)
                                          ),
                                          child: Material(
                                            child: ListTile(

                                              title: Text('Receipt : ${index+1}'),
                                              subtitle:Text('User : ${snapshot.data![index].UserId}'),

                                              trailing: Text("Check Details"),
                                              onTap: () {
                                                var docid=snapshot.data![index].id!;

                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ApproveOrRejectPayment(snapshot.data![index].bill, snapshot.data![index].reciept, snapshot.data![index].UserId, docid)));

                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    else{
                                      return Container();
                                    }
                                  }, separatorBuilder: (BuildContext context, int index) {
                                  return const Divider(); },
                                ),
                              ),

                            ],
                          ),
                        ) ,
                      ],
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
Future<List<Payment_model>> getAllData() async {
  return await paymentRepo.getAllReceiptDetail();
}
Future<List<User_model>> getAlluserData() async {
  return await userRepo.getAllUserDetail();
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
    ..subject = 'Takhleeqish! Payment Update'
    ..text = 'This is the plain text.\nThis is line 2 of the text part.'
    ..html = "<h1>An artifact is uploaded for auction.</h1>\n<p>Hey! An amazing oppurtunity to buy an amazing Art piece is about to get live go check it out.</p>";

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
}}