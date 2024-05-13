import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:takhleekish/Artist/throughDashboard/Sessions/userSessionRequests/reqSessionDetails.dart';
import 'package:takhleekish/User/UserSessionDatabase/sessionController.dart';
import 'package:takhleekish/User/UserSessionDatabase/sessionModel.dart';
import 'package:takhleekish/User/UserSessionDatabase/sessionRepository.dart';

import '../../../Navbar/navbar.dart';
import '../../../artistPersonal/artist_authentication.dart';
import '../../../artistPersonal/artist_model.dart';
import '../../../artistPersonal/artist_repository.dart';
import '../../../auction/auctionRepository.dart';
import '../../../controllers/artist_controller.dart';


class UserRequestPage extends StatelessWidget
{
  final controller = Get.put(Artist_Controller());

  final authrepo = Get.put(Artist_Auth());

  final artistRepo = Get.put(Artist_repo());
  final auctionRepo=Get.put(Auction_Repo());
  final sessionRepo=Get.put(Session_UserRepo());
  final FirebaseAuth _auth=FirebaseAuth.instance;
  var email;
  var count=0;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: Navbar(),
      appBar: AppBar(
        title: const Text("Session Requests", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 30)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
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
        ),      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              Artist_model artistModel = snapshot.data!;
              email=snapshot.data!.email;
              print(email);
              return FutureBuilder(
                future: getAllData(email),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return Scaffold(
                          body:Container(
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
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ListView.separated(
                                      itemCount: snapshot.data!.length, // Number of auction (fetch from the database)
                                      itemBuilder: (context, index) {
                                        if(snapshot.data![index].checkReqStatus=="false")
                                        {count++;
                                          print(index);
                                          return Slidable(
                                            actionPane: SlidableDrawerActionPane(),
                                            actionExtentRatio: 0.25,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(15.0)
                                              ),
                                              child: ListTile(
                                                  title: Text('Session ${count}'),
                                                  subtitle: Text("Session Title:  ${snapshot.data![index].Title}"),
                                                  trailing: Text("Check Details"
                                                  ),
                                                  onTap: () {
                                                    DateTime date = DateTime
                                                        .parse(snapshot
                                                        .data![index]
                                                        .sessionDate);
                                                    print(date);

                                                    String startingTimeString = snapshot
                                                        .data![index]
                                                        .startingTime;
                                                    String sttimeSubstring = startingTimeString
                                                        .substring(
                                                        startingTimeString
                                                            .indexOf("(") + 1,
                                                        startingTimeString
                                                            .indexOf(")"));
                                                    List<
                                                        String> sttimeParts = sttimeSubstring
                                                        .split(':');

                                                    if (sttimeParts.length ==
                                                        2) {
                                                      // Parse the hours and minutes into integers
                                                      int sthours = int
                                                          .tryParse(
                                                          sttimeParts[0]) ??
                                                          0; // Use 0 as default if parsing fails
                                                      int stminutes = int
                                                          .tryParse(
                                                          sttimeParts[1]) ??
                                                          0; // Use 0 as default if parsing fails
                                                      TimeOfDay startingTime = TimeOfDay(
                                                          hour: sthours,
                                                          minute: stminutes);
                                                      var docid=snapshot.data![index].id?? "No id";
                                                      print(startingTime);
                                                      Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (
                                                                context) =>
                                                                ReqSessionDetailPage(
                                                                  snapshot
                                                                      .data![index]
                                                                      .userEmail,
                                                                  snapshot
                                                                      .data![index]
                                                                      .Title,
                                                                  startingTime,
                                                                  date, id: docid,

                                                                )),);
                                                    }

                                                    else {
                                                      // Handle the case where the time string is not in the expected format
                                                      print(
                                                          'Invalid time format');
                                                    }
                                                  }),
                                            ),
                                          );
                                        }
                                        else
                                        {
                                          return Container();
                                        }


                                      }, separatorBuilder: (BuildContext context, int index) { return const Divider(); },
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ) ,
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


  Future<Artist_model?> getData() async {
    final email = authrepo.firebaseUser.value?.email;
    if (email != null) {
      return await artistRepo.getArtistDetail(email);
    }
    return null; // Handle the case where email is null
  }

  Future<List<Session_User_Model>> getAllData(String email) async {
    return await sessionRepo.getPesronsalSessionReq(email);
  }


}