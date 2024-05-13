import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:takhleekish/Artist/throughDashboard/Sessions/call/callSession.dart';

class DetailSessionPage extends StatefulWidget
{
  final String UserEmail;
  final String title;
  final DateTime date;
  final TimeOfDay sessionTime;
  DetailSessionPage(
      this.UserEmail,this.title,this.sessionTime,this.date);
  @override
  State<DetailSessionPage> createState() => _DetailSessionPageState();
}

class _DetailSessionPageState extends State<DetailSessionPage>
{

  bool isTimeValid = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Start a periodic timer that triggers every second
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // Call the function to check time validity
      checkTimeValidity();
      // Call setState to update the UI
      setState(() {});
    });
  }

  @override
  void dispose() {
    // Cancel the timer to prevent memory leaks when the widget is disposed
    _timer.cancel();
    super.dispose();
  }


  void checkTimeValidity() {
    final now = DateTime.now();
    final currentTime = TimeOfDay(hour: now.hour, minute: now.minute);

    // Convert the widget date and time to a DateTime object
    final widgetDateTime = DateTime(
      widget.date.year,
      widget.date.month,
      widget.date.day,
      widget.sessionTime.hour,
      widget.sessionTime.minute,

    );

    // Check if the current date is after or the same as the widget's date
    if (now.isAfter(widgetDateTime) || now.isAtSameMomentAs(widgetDateTime)) {
      // If the dates are the same, check if the current time is after the scheduled time
      if (now.isAtSameMomentAs(widgetDateTime) && currentTime.hour >= widget.sessionTime.hour && currentTime.minute >= widget.sessionTime.minute) {
        isTimeValid = true;
      }
      // If the current date is after the scheduled date, the time is valid
      else if (now.isAfter(widgetDateTime)) {
        isTimeValid = true;
      } else {
        // Otherwise, the time is not yet valid
        isTimeValid = false;
      }
    } else {
      // If the current date is before the scheduled date, the time is not yet valid
      isTimeValid = false;
    }
    print(isTimeValid);

  }


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
                    Text("Artist Email",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
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
                    if(isTimeValid)
                      Container(
                        width: screenWidth*0.5,
                        height: screenHeight*0.07,
                        child:Container(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed:()async {

                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>callSession(callID: "1")));
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
                                Center(child: Text("Start Session",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),
                              ),
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
}
