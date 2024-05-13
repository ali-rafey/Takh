import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:takhleekish/Artist/Navbar/navbar.dart';

import '../postSession/session.dart';
import '../scheduledSessions/scheduledSessionPage.dart';

class SessionSelectPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(),
      appBar: AppBar(
        title: const Text(
          "Select Session",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 30),
        ),
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
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 880,
            child: Image.asset("assests/images/dbpic2.jpeg"
              ,fit: BoxFit.fitHeight,),
            //add background image here
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15,bottom: 18),
                  child: Container(
                    width: 220,
                    height: 200,
                    child: ElevatedButton(onPressed:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>scheduledSession()));

                    }, child:Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(right:15.0,left: 15.0,top: 5,),
                            child: Image.asset("assests/images/calendar.png",fit: BoxFit.fitWidth)
                        ),
                        Text("Scheduled Sessions",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 18),),
                      ],
                    ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)
                          )
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 15,bottom: 18),
                  child: Container(
                    width: 220,
                    height: 200,
                    child: ElevatedButton(onPressed:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PaintingSessionPage()));
                    }, child:Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(right:15.0,left: 15.0,top: 17,bottom:8),
                            child: Image.asset("assests/images/workshop.png",fit: BoxFit.fitWidth)
                        ),
                        Text("Post Session",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 18),),
                      ],
                    ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)
                          )
                      ),
                    ),
                  ),
                )

              ],
            ),
          )
        ],

      ),
    );

  }

}