import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import 'adminAuction/approveAuction/auctionPage.dart';
import 'adminAuction/liveAuctionStatus/liveAucStatus.dart';

class SelectAucWork extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth=FirebaseAuth.instance;
    return Scaffold(
      // drawer: AdminNavbar(),
      appBar:AppBar(
        title: const Text("Auctions",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30),),
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
        actions: <Widget>[
          IconButton(
            onPressed: () {
              _auth.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage()));

            },
            icon: Icon(Icons.exit_to_app,color: Colors.white,),
          ),
        ],
      ),
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
        child: Center(

            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15,bottom: 18,left: 10),
                    child: Container(
                      width: 220,
                      height: 200,
                      child: ElevatedButton(onPressed:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminAuctionPage()));
                      }, child:Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right:20.0,left: 15.0,top: 11),
                            child: Image.asset("assests/images/hammer.png"),
                          ),
                          SizedBox(height: 10,),
                          Text("Approve Auctions",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 20),),
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
                    padding: const EdgeInsets.only(top: 15,bottom: 18,left: 10),
                    child: Container(
                      width: 220,
                      height: 200,
                      child: ElevatedButton(onPressed:(){
                        String boolcheck="false";
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LiveAuction(boolcheck)));
                      }, child:Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right:20.0,left: 15.0,top: 11),
                            child: Image.asset("assests/images/research.png"),
                          ),
                          SizedBox(height: 10,),
                          Text("Live Auction",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 20),),
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

                ],
              ),
            )

        ),
      ),);
  }

}