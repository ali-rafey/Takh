import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:takhleekish/Admin/throughDashboard/adminAuction/liveAuctionDatabase/liveAuctionController.dart';
import 'package:takhleekish/Admin/throughDashboard/adminAuction/liveAuctionDatabase/liveAuctionModel.dart';
import 'package:takhleekish/Admin/throughDashboard/adminAuction/liveAuctionDatabase/liveAuctionRepository.dart';

import '../../../../Artist/auction/auctionModel.dart';
import '../../../../Artist/auction/auctionRepository.dart';

class LiveAuction extends StatefulWidget
{
  final String basebidCheck;

  LiveAuction(this.basebidCheck);

  @override
  State<LiveAuction> createState() => _LiveAuctionState();
}

class _LiveAuctionState extends State<LiveAuction> {
  final auctionRepo = Get.put(Auction_Repo());
  final liveAuctionRepo = Get.put(live_Auction_Repo());
  late Timer _timer;


  void initState() {
    super.initState();
    // Start the timer when the widget is initialized
    _startTimer();
  }
  void dispose() {
    // Dispose the timer when the widget is disposed
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    // Start a periodic timer that runs every minute
    _timer = Timer.periodic(Duration(minutes: 1), (timer) async {
      setState(() {});
      // Fetch live auctions
      List<Live_Auction_model> liveAuctions = await getLiveAuction();
      // Call the method with the fetched live auctions
      print("chajsj");
      _checkAndDeleteExpiredAuctions(liveAuctions);
    });
  }

  void _checkAndDeleteExpiredAuctions(List<Live_Auction_model> liveAuctions) async {
    // Get the current time
    DateTime currentTime = DateTime.now();
    print("Current Time: $currentTime");

    // Iterate through live auctions
    for (var auction in liveAuctions) {
      // Parse ending time from the auction
      String endingTimeString = auction.endingtime;
      print("Ending Time String: $endingTimeString");

      // Extract the time substring (e.g., "12:15 AM")
      List<String> timeParts = endingTimeString.split(' ');
      if (timeParts.length == 2) {
        List<String> hourMinuteParts = timeParts[0].split(':');
        if (hourMinuteParts.length == 2) {
          int hour = int.tryParse(hourMinuteParts[0]) ?? 0;
          int minute = int.tryParse(hourMinuteParts[1]) ?? 0;
          bool isAM = timeParts[1].toLowerCase() == 'am';

          // Adjust current time to match 12-hour format with AM/PM
          if (!isAM && hour < 12) {
            hour += 12;
          } else if (isAM && hour == 12) {
            // Special case: midnight (12:00 AM) should be represented as 0:00
            hour = 0;
          }

          // Create a DateTime object for the ending time
          DateTime endingTime = DateTime(
            currentTime.year,
            currentTime.month,
            currentTime.day,
            hour,
            minute,
          );
          print("Ending Time: $endingTime");

          // Check if the current time is after the ending time
          if (currentTime.isAfter(endingTime)) {
            print("Current time is after ending time.");

            // Add one minute to the ending time
            DateTime endingTimePlusOneMinute = endingTime.add(Duration(minutes: 1));
            print("Ending Time + 1 minute: $endingTimePlusOneMinute");

            // Check if the current time is after one minute past the ending time
            if (currentTime.isAfter(endingTimePlusOneMinute)) {
              print("Current time is after one minute past ending time.");
              // Delete the auction from the database
              await deleteLiveAuction(auction.id!);
              print("Auction ${auction.id} deleted.");
            }
          } else {
            print("Current time is not after ending time.");
          }
        }
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Live Auction Status", style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w600, fontSize: 30)),
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
              for (int i = 0; i < snapshot.data!.length; i++) {
                if (snapshot.data![i].isLive == "true") {
                  String basebid = snapshot.data![i].liveBaseBid;
                  String name = snapshot.data![i].artName;
                  String endingTimeString = snapshot.data![i].endingTime;
                  // Extract the substring containing the time (e.g., "14:10")
                  String endtimeSubstring =
                  endingTimeString.substring(
                      endingTimeString.indexOf("(") + 1,
                      endingTimeString.indexOf(")"));
                  List<String> endtimeParts = endtimeSubstring.split(':');
                  if (endtimeParts.length == 2) {
                    // Parse the hours and minutes into integers
                    int endhours = int.tryParse(endtimeParts[0]) ?? 0;
                    int endminutes = int.tryParse(endtimeParts[1]) ?? 0;
                    // Create a DateTime object
                    DateTime endingTime = DateTime(
                        DateTime
                            .now()
                            .year,
                        DateTime
                            .now()
                            .month,
                        DateTime
                            .now()
                            .day,
                        endhours,
                        endminutes);

                    DateTime endingTimePlusOneHour =
                    endingTime.add(Duration(hours: 1));
                    // if (endingTime.isAfter(endingTimePlusOneHour)) {
                    //   print("sssss");
                    //   FirebaseFirestore.instance.collection('Live_Auction')
                    //       .get()
                    //       .then((snapshot) {
                    //     for (DocumentSnapshot doc in snapshot.docs) {
                    //       doc.reference.delete();
                    //     }
                    //   }).catchError((error) {
                    //     print('Error deleting collection: $error');
                    //   });
                    // }

                    return FutureBuilder(
                      future: getLiveAuction(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
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
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text("${name}",
                                            style: TextStyle(fontSize: 22,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),),
                                          SizedBox(width: 50,),
                                          Text("Base Bid : ${basebid}",
                                            style: TextStyle(fontSize: 22,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),),
                                        ],
                                      ),
                                      SizedBox(height: 20,),
                                      Expanded(
                                        child: ListView.separated(
                                          itemCount: snapshot.data!.length,
                                          // Number of auction (fetch from the database)
                                          itemBuilder: (context, index) {
                                            return Slidable(
                                              actionPane: SlidableDrawerActionPane(),
                                              actionExtentRatio: 0.25,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius
                                                        .circular(15.0)
                                                ),
                                                child: ListTile(
                                                    leading: ClipOval(
                                                        child: Image.network(
                                                            snapshot
                                                                .data![index]
                                                                .url)),
                                                    title: Text(
                                                        'User: ${snapshot
                                                            .data![index]
                                                            .userID}'),
                                                    subtitle: Text(
                                                        "Bid amount: ${snapshot
                                                            .data![index]
                                                            .bidAmount}"),

                                                    onTap: () {}
                                                ),
                                              ),
                                            );
                                          },
                                          separatorBuilder: (
                                              BuildContext context,
                                              int index) {
                                            return const Divider();
                                          },
                                        ),
                                      ),

                                    ],
                                  ),
                                ),

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
                    );
                  }
                }
              }
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
          return Container(
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
          );
        },
      ),
    );
  }

  Future<List<Auction_model>> getAllData() async {
    return await auctionRepo.getAllAuctionDetail();
  }

  Future<List<Live_Auction_model>> getLiveAuction() async {
    return await liveAuctionRepo.getAllAuctionDetail();
  }

  Future<void> deleteLiveAuction(String auctionId) async {
    try {
      await FirebaseFirestore.instance.collection('Live_Auction').doc(auctionId).delete();
      print('Auction deleted successfully');
    } catch (error) {
      print('Error deleting auction: $error');
    }
  }
  String _formatTimeOfDay(TimeOfDay timeOfDay) {
    int hour = timeOfDay.hour;
    int minute = timeOfDay.minute;

    // Format the time as HH:MM
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

}