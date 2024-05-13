import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:takhleekish/User/UserSessionDatabase/sessionModel.dart';
import 'package:takhleekish/User/UserSessionDatabase/sessionRepository.dart';
import 'package:takhleekish/User/credentialsFile/user_model.dart';
import 'package:takhleekish/User/credentialsFile/user_repository.dart';
import 'package:takhleekish/User/throughNavBar/userSessions/scheduled/detailSceduledSessionPage.dart';

import '../../../../Artist/Navbar/navbar.dart';
import '../../../../Artist/artistPersonal/artist_authentication.dart';
import '../../../../Artist/artistPersonal/artist_model.dart';
import '../../../../Artist/artistPersonal/artist_repository.dart';
import '../../../../Artist/auction/auctionModel.dart';
import '../../../../Artist/auction/auctionRepository.dart';
import '../../../../Artist/controllers/artist_controller.dart';

class UserScheduledSessions extends StatelessWidget
{
  final controller = Get.put(Artist_Controller());

  final authrepo = Get.put(Artist_Auth());

  final userRepo = Get.put(User_repo());
  final SessionRepo=Get.put(Session_UserRepo());
  var email;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              email=snapshot.data!.email;
              return FutureBuilder(
                future: getAllData(email),
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

                                          if(snapshot.data![index].checkReqStatus=="true")
                                            {
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
                                                    title: Text('Session ${index + 1}'),
                                                    subtitle: Text("Session Title:  ${snapshot.data![index].Title}"),
                                                    trailing: Text("Check Details"),
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
                                                                  context) =>DetailScheduledSessionPage(snapshot.data![index].artistEmail,
                                                                  snapshot.data![index].Title, startingTime, date)),);

                                                      }

                                                      else {
                                                        // Handle the case where the time string is not in the expected format
                                                        print(
                                                            'Invalid time format');
                                                      }
                                                    },
                                                  ),
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
  Future<List<Session_User_Model>> getAllData(String email) async {
    return await SessionRepo.getApprovedUserSessions(email);
  }
}