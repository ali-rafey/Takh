import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:takhleekish/Admin/compainsCheck/complainDetail.dart';
import 'package:takhleekish/User/throughNavBar/complainsPage/complainDatabase/complainModel.dart';
import 'package:takhleekish/User/throughNavBar/complainsPage/complainDatabase/complainRepository.dart';

import '../../Artist/throughNavbar/ComplainsPage/artistComplainsPage.dart';

class ComplainDashboardPage extends StatelessWidget{
  List<dynamic> dynamicEmailArray = [];
final complainRepo=Get.put(ComplainRepo());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: FutureBuilder(
          future: getAllData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Scaffold(
                    body:Stack(
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
                                  itemCount: snapshot.data!.length, // Number of auction (fetch from the database)
                                  itemBuilder: (context, index) {
                                    return Slidable(
                                      actionPane: SlidableDrawerActionPane(),
                                      actionExtentRatio: 0.25,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(15.0)
                                        ),
                                        child: ListTile(
                                          title: Text('Complain ${index + 1}'),
                                          subtitle: Text("Complainant:  ${snapshot.data![index].userEmail}"),
                                          trailing: Text("Check Details"),
                                          onTap: () {
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (context) => ComplainDetails(snapshot.data![index].url, snapshot.data![index].userEmail, snapshot.data![index].complain)),);
                                          },
                                        ),
                                      ),
                                    );
                                  }, separatorBuilder: (BuildContext context, int index) { return const Divider(); },
                                ),
                              ),

                            ],
                          ),
                        ) ,
                      ],
                    )
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
      )
    );
  }
  Future<List<ComplainModel>> getAllData() async {
    return await complainRepo.getAllComplainDetail();
  }
}