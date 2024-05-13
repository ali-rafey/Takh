import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:takhleekish/Artist/artifacts/artifactModel.dart';

class ApproveOrRejectAuction extends StatefulWidget{
  final String url;
  final String baseBid;
  final TimeOfDay enTime;
  final String email;
  final DateTime date;
  final TimeOfDay stTime;



  ApproveOrRejectAuction(
      this.url, this.baseBid,this.enTime,this.stTime,this.date, this.email);

  @override
  State<ApproveOrRejectAuction> createState() => _ApproveOrRejectAuctionState();
}

class _ApproveOrRejectAuctionState extends State<ApproveOrRejectAuction> {
  @override
  Widget build(BuildContext context) {
    double screenHeight=MediaQuery.of(context).size.height;
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
            Container(
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
                  Text("Base Bid",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  Text("RS ${widget.baseBid}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
                  SizedBox(
                    height:screenHeight*0.02,
                  ),
                  Text("Artist Email",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  Text(" ${widget.email}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),

                  SizedBox(
                    height:screenHeight*0.02,
                  ),
                  Text("Date",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  Text("${widget.date.month}/${widget.date.day}/${widget.date.year}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),

                  SizedBox(
                    height:screenHeight*0.02,
                  ),
                  Text("Starting time",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  Text("${_formatTime(widget.stTime)}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),                    SizedBox(
                    height:screenHeight*0.02,
                  ),
                  Text("Ending Time",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  Text("${_formatTime(widget.enTime)}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),

                ],
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