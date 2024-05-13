import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:takhleekish/Admin/throughDashboard/adminAuction/liveAuctionDatabase/liveAuctionModel.dart';
import 'package:takhleekish/Admin/throughDashboard/adminAuction/liveAuctionDatabase/liveAuctionRepository.dart';
import '../../../../Artist/auction/auctionController.dart';
import '../../../../Artist/auction/auctionModel.dart';
import '../../../../Artist/auction/auctionRepository.dart';

class ApprovedBidPage extends StatefulWidget{
  final String url;
  final String baseBid;
  final String name;
  final String docid;
  final TimeOfDay enTime;
  final String email;
  final String bidStatus;
  final DateTime date;
  final TimeOfDay stTime;
  final String buyer;

  ApprovedBidPage(
      this.url, this.baseBid,this.enTime,this.stTime,this.date, this.email, this.name,this.bidStatus,{required this.docid, required this.buyer});
  @override
  State<ApprovedBidPage> createState() => _ApprovedBidPageState();
}

class _ApprovedBidPageState extends State<ApprovedBidPage> {
  TextEditingController bid=TextEditingController();
  bool isTimeValid=false;
  late bool isBiddingDone;

  final auctionRepo=Get.put(Auction_Repo());

  final FirebaseAuth _auth=FirebaseAuth.instance;
  final formkey=GlobalKey<FormState>();
  final controller=Get.put(Auction_Controller());
  late TextEditingController bidController;
   String bidAmount= "";

  @override
  void initState() {
    super.initState();
    bidController = TextEditingController();

  }

  void checkTimeValidity() {
    final now = DateTime.now();
    final currentTime = TimeOfDay(hour: now.hour, minute: now.minute);

    // Convert the widget date to a DateTime object
    final widgetDate = DateTime(
        widget.date.year,
        widget.date.month,
        widget.date.day,
        widget.stTime.hour,
        widget.stTime.minute
    );

    final widgetEndDate = DateTime(
        widget.date.year,
        widget.date.month,
        widget.date.day,
        widget.enTime.hour,
        widget.enTime.minute
    );

    // Check if the current date is within the range of the bidding period
    if (now.isAfter(widgetDate) && now.isBefore(widgetEndDate)) {
      // Check if the current time is within the bidding hours
      if (currentTime.hour >= widget.stTime.hour &&
          currentTime.hour < widget.enTime.hour) {
        setState(() {
          isTimeValid = true;
          isBiddingDone=true;
        });
      } else if (currentTime.hour == widget.enTime.hour &&
          currentTime.minute <= widget.enTime.minute) {
        setState(() {
          isTimeValid = true;
          isBiddingDone=true;
        });
      } else {
        setState(() {
          isTimeValid = false;

        });
      }
    } else {
      setState(() {
        isTimeValid = false;

      });
    }
    print(isTimeValid);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight=MediaQuery.of(context).size.height;
print('${widget.bidStatus}');
print("Ghazi");
if({widget.bidStatus}=='false')
    {
      isBiddingDone=false;
    }
    else
      {
        isBiddingDone=true;
      }

    print(isBiddingDone);
    setState(() {
      checkTimeValidity();
      currentBid().then((value) {
        setState(() {
          bidAmount = value;
        });
      }).catchError((error) {
        print('Error occurred: $error');
      });
    });



    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: screenHeight,
              child: Image.asset("assests/images/dbpic2.jpeg"
                ,fit: BoxFit.fitHeight,),
              //add background image here
            ),
            Form(
              key: formkey,
              child: Container(
                child: Column(
                  children: [
                    SizedBox(height: screenHeight*0.1,),
                    Center(
                      child: Container(
                        width: 300,
                        height: 300,
                        child: Image.network(widget.url),
                      ),
                    ),
                    SizedBox(
                      height:screenHeight*0.04,
                    ),
                    Text("Current Bid",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Text("RS ${bidAmount}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
                    SizedBox(
                      height:screenHeight*0.01,
                    ),
                    Text("Art Name",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Text(" ${widget.name}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),

                    SizedBox(
                      height:screenHeight*0.01,
                    ),
                    Text("Date",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Text("${widget.date.month}/${widget.date.day}/${widget.date.year}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
                    SizedBox(
                      height:screenHeight*0.01,
                    ),
                    Text("Ending Time",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Text("${_formatTime(widget.enTime)}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),

                    SizedBox(
                      height:screenHeight*0.01,
                    ),
                    if(isTimeValid)
                    Container(
                      width: 300,
                      height: 50,
                      child: TextFormField(
                        controller: bidController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if(value!.isEmpty)
                          {
                            return 'Enter amount';
                          }
                          else {
                            int? newValue = int.tryParse(value);
                            int currentBidAmount = int.tryParse(bidAmount) ?? 0; // Convert bidAmount to integer or use 0 if it's not parseable
                            if (newValue != null && newValue > currentBidAmount) {
                              bidController.text = value;
                            }
                            else{

                              Get.snackbar("Attention", "Bid amount amount should be higher then the current amount.",
                                  snackPosition:SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red.withOpacity(0.1),
                                  colorText: Colors.black);
                              return '';
                            }

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
                            padding: const EdgeInsets.only(bottom: 10.0,top: 3),
                            child: Container(
                                height: 16,
                                child: Image.asset("assests/images/bidAuct.png")),
                          ),
                          label:Padding(
                            padding: const EdgeInsets.only(left: 6.0),
                            child: Text("Enter bid amount"),
                          ) ,
                        ),

                      ),
                    ),
                    SizedBox(
                      height:screenHeight*0.02,
                    ),
                    Container(
                      width: 180,
                      height: 45,
                      child:Container(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed:()   async {
                            if(isTimeValid){
                              if(formkey.currentState!.validate()){
                                print(widget.docid);
                                print(bidController);
                                String time=_formatTime(widget.enTime);;
                                final liveAuc=Live_Auction_model(
                                    bidAmount: bidController.text,
                                    userID: widget.email,
                                    url: widget.url, endingtime:time );
                                Get.put(live_Auction_Repo()).createAuction(liveAuc);
                                await FirebaseFirestore.instance.collection("Auction").doc(widget.docid)
                                    .update(
                                    {
                                      'Bid':bidController.text,
                                      'BidStatus':"true",
                                      'isLive':"true",
                                      'liveBaseBid':widget.baseBid,
                                      'Buyer':widget.buyer,
                                    }
                                ).whenComplete(() {
                                  Get.snackbar("Congratulations", "Bid has been Placed",
                                      snackPosition:SnackPosition.BOTTOM,
                                      backgroundColor: Colors.green.withOpacity(0.1),
                                      colorText: Colors.white);
                                  bidController.clear();
                                }
                                ).catchError((error,stackTrace){
                                  Get.snackbar("Error", "Something went wrong. Try again",
                                      snackPosition:SnackPosition.BOTTOM,
                                      backgroundColor: Colors.redAccent.withOpacity(0.1),
                                      colorText: Colors.red);
                                  print(error.toString());});


                              }
                            }
                            else
                            {
                              await FirebaseFirestore.instance.collection("Auction").doc(widget.docid)
                                  .update(
                                  {
                                    'isLive':"false",

                                  }
                              );
                              print(isBiddingDone);
                              if(isBiddingDone)
                              {
                                Get.snackbar("Sorry", "Currently this is not the bidding period",
                                    snackPosition:SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red.withOpacity(0.3),
                                    colorText: Colors.white);
                              }
                              else
                              {
                                Get.snackbar("Sorry", "Currently this is not the bidding period",
                                    snackPosition:SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red.withOpacity(0.3),
                                    colorText: Colors.white);
                              }

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
                              child:  Row(
                                children: [
                                  SizedBox(width: 18,),
                                  FaIcon(FontAwesomeIcons.check,color: Colors.white,),
                                  SizedBox(width: 35,),
                                  Text("Bid",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 20),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                    ),


                    SizedBox(
                      height:screenHeight*0.02,
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

  Future<Auction_model> getData() async {
    return await auctionRepo.getPesronsalAuction(widget.name);
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

  void fetchBidAmount(String bidAmount) async {
    bidAmount = await currentBid();

  }

  Future<String> currentBid() async {
    var doc = widget.docid;
    print(doc);
    late DocumentSnapshot documentSnapshot;
    try {
      // Await the result of the Firestore operation directly
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection("Auction").doc(doc).get();

      // Assign the result to documentSnapshot
      documentSnapshot = snapshot;

      // Extract the bid amount
      String amount = documentSnapshot['Bid'];
      print(amount);

      // Return the bid amount
      return amount;
    } catch (error) {
      // Handle any errors that occur during the Firestore operation
      print("Error fetching bid: $error");
      return ''; // Return an empty string or handle error as appropriate
    }
  }
  Future<String> currentEndTime() async {
    var doc = widget.docid;
    print(doc);
    late DocumentSnapshot documentSnapshot;

    try {
      // Await the result of the Firestore operation directly
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection("Auction").doc(doc).get();

      // Assign the result to documentSnapshot
      documentSnapshot = snapshot;

      // Extract the bid amount
      String endTime = documentSnapshot['Ending_Time'];
      print(endTime);

      // Return the bid amount
      return endTime;
    } catch (error) {
      // Handle any errors that occur during the Firestore operation
      print("Error fetching Time: $error");
      return ''; // Return an empty string or handle error as appropriate
    }
  }


}