import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:takhleekish/User/Navbar/userNavbar.dart';

import '../../../../Artist/artistPersonal/artist_authentication.dart';
import '../../../../Artist/artistPersonal/artist_model.dart';
import '../../../../Artist/artistPersonal/artist_repository.dart';
import '../../../../Artist/auction/auctionModel.dart';
import '../../../../Artist/auction/auctionRepository.dart';
import '../../../../Artist/controllers/artist_controller.dart';
import 'approvedBidPage.dart';

class ApprovedAuctionPage extends StatefulWidget
{
  final String buyer;
  ApprovedAuctionPage
      (
      this.buyer
      );
  @override
  State<ApprovedAuctionPage> createState() => _ApprovedAuctionPageState();
}

class _ApprovedAuctionPageState extends State<ApprovedAuctionPage> {
  final controller = Get.put(Artist_Controller());

  final authrepo = Get.put(Artist_Auth());

  final artistRepo = Get.put(Artist_repo());

  final auctionRepo=Get.put(Auction_Repo());

  final FirebaseAuth _auth=FirebaseAuth.instance;

  var email;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: UserNavbar(),
      appBar: AppBar(
        title: const Text("Auction Page", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 30)),
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
        ),
      ),
      body: FutureBuilder(
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

                                  if(snapshot.data![index].checkAuc=='true')
                                    {
                                      String startingTimeString = snapshot

                                          .data![index].startingTime;
                                      String sttimeSubstring = startingTimeString
                                          .substring(
                                          startingTimeString.indexOf("(") +
                                              1,
                                          startingTimeString.indexOf(")"));
                                      List<
                                          String> sttimeParts = sttimeSubstring
                                          .split(':');
                                      int sthours = int.tryParse(
                                          sttimeParts[0]) ??
                                          0; // Use 0 as default if parsing fails
                                      int stminutes = int.tryParse(
                                          sttimeParts[1]) ??
                                          0; // Use 0 as default if parsing fails
                                      TimeOfDay startingTime = TimeOfDay(
                                          hour: sthours,
                                          minute: stminutes);
                                      return Slidable(
                                        actionPane: SlidableDrawerActionPane(),
                                        actionExtentRatio: 0.25,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(15.0)
                                          ),
                                          child: ListTile(
                                              leading: ClipOval(child:Image.network(snapshot.data![index].url)),
                                              title: Text('Auction ${index + 1}'),
                                              subtitle: Text("Starting Time: ${_formatTime(startingTime)}"),
                                              trailing: Text(
                                                  "Details"
                                              ),
                                              onTap: () {
                                                DateTime date = DateTime.parse(
                                                    snapshot.data![index]
                                                        .auctionDate);
                                                print(date);



                                                String endingTimeString = snapshot
                                                    .data![index].endingTime;
                                                // Extract the substring containing the time (e.g., "14:10")
                                                String endtimeSubstring = endingTimeString
                                                    .substring(
                                                    endingTimeString.indexOf("(") + 1,
                                                    endingTimeString.indexOf(")"));

                                                List<
                                                    String> endtimeParts = endtimeSubstring
                                                    .split(':');
                                                if (endtimeParts.length == 2 &&
                                                    sttimeParts.length ==
                                                        2) { // Parse the hours and minutes into integers
                                                  int endhours = int.tryParse(
                                                      endtimeParts[0]) ??
                                                      0; // Use 0 as default if parsing fails
                                                  int endminutes = int.tryParse(
                                                      endtimeParts[1]) ??
                                                      0; // Use 0 as default if parsing fails
                                                  // Create a TimeOfDay object
                                                  TimeOfDay endingTime = TimeOfDay(
                                                      hour: endhours,
                                                      minute: endminutes);
                                                  // Parse the hours and minutes into integers


                                                  print(startingTime);
                                                  String docid=snapshot.data![index].id?? "No id";

                                                  print(snapshot.data![index].checkBidStatus);

                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ApprovedBidPage(snapshot.data![index].url,snapshot.data![index].bid,
                                                                  endingTime,startingTime,date,
                                                                  snapshot.data![index].ArtistId,snapshot.data![index].artName, snapshot.data![index].checkBidStatus,docid: docid, buyer: widget.buyer,)));
                                                }
                                              }
                                          ),
                                        ),
                                      );
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
      ),
    );
  }

  Future<List<Auction_model>> getAllData() async {
    return await auctionRepo.getAllAuctionDetail();
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
}

