import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:takhleekish/Admin/navbar/adminNavbar.dart';

import '../../Artist/Navbar/navbar.dart';
import '../../main.dart';
import '../compainsCheck/complainDashboard.dart';
import '../throughDashboard/adminAuction/approveAuction/auctionPage.dart';
import '../throughDashboard/adminExhibition/adminExhibitionPage.dart';
import '../throughDashboard/selectAuc.dart';

class AdminDashboard extends StatelessWidget{
  final FirebaseAuth _auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminNavbar(),
      appBar:AppBar(
        title: const Text("Admin Dashboard",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30),),
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
                    width: 200,
                    height: 200,
                    child: ElevatedButton(onPressed:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ComplainDashboardPage()));
                    }, child:Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right:20.0,left: 15.0,top: 17),
                          child: Image.asset("assests/images/complain.png"),
                        ),
                        SizedBox(height: 10,),
                        Text("Complaints",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 22),),
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
                    width: 200,
                    height: 200,
                    child: ElevatedButton(onPressed:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectAucWork()));
                    }, child:Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right:15.0,left: 15.0,top: 17),
                          child: Image.asset("assests/images/adminAuctions.png"),
                        ),
                        SizedBox(height: 10,),
                        Text("Auction",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 22),),
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