import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:takhleekish/Artist/throughDashboard/exhibition.dart';
import 'package:takhleekish/Artist/throughDashboard/postArtifact/postArtifacts.dart';
import '../Navbar/navbar.dart';
import '../throughDashboard/ArtistAuction/auction.dart';
import '../throughDashboard/Sessions/artistSessions/sessionSelectPage/sessionSelectPage.dart';
import '../throughDashboard/checkUser/verifyGmail.dart';
import '../throughDashboard/postArtifact/verifyProduct.dart';

class ArtistDashboard extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return Scaffold(
    drawer: Navbar(),
          appBar:AppBar(
            title: const Text("Dashboard", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 30)),
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
            children:[
              Container(
                width: double.infinity,
                height: 880,
                child: Image.asset("assests/images/dbpic2.jpeg"
                  ,fit: BoxFit.fitHeight,),
                //add background image here
              ),
              Padding(
                padding: const EdgeInsets.only(top: 80.0),
                child: SingleChildScrollView(
                child: Center(
                    child: Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 15,bottom: 18,left: 10),
                                child: Container(
                                  width: 180,
                                  height: 180,
                                  child: ElevatedButton(onPressed:(){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>VerifyProduct()));
                                  }, child:Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right:15.0,left: 15.0,top: 17),
                                        child: Image.asset("assests/images/uploadartist.png"),
                                      ),
                                      SizedBox(height: 10,),
                                      Text("Post Artifact",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 18),),
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
                                width: 10,
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 15,bottom: 18),
                                child: Container(
                                  width: 180,
                                  height: 180,
                                  child: ElevatedButton(onPressed:(){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ExhibitionAnnouncementPage()));
                                  }, child:Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right:15.0,left: 15.0,top: 17),
                                        child: Image.asset("assests/images/art-show.png",fit: BoxFit.fitWidth),
                                      ),
                                      SizedBox(height: 10,),

                                      Text("Exhibition",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 18),),
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

                            ],
                          ),

                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 15,bottom: 18,left: 10),
                                child: Container(
                                  width: 180,
                                  height: 180,
                                  child: ElevatedButton(onPressed:(){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AuctionPage()));
                                  }, child:Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right:15.0,left: 15.0,top: 17),
                                        child: Image.asset("assests/images/charity.png",fit: BoxFit.fitWidth),
                                      ),
                                      SizedBox(height: 10,),

                                      Text("Auction",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 18),),
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
                                width: 10,
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 15,bottom: 18),
                                child: Container(
                                  width: 180,
                                  height: 180,
                                  child: ElevatedButton(onPressed:(){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SessionSelectPage()));
                                  }, child:Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right:15.0,left: 15.0,top: 17),
                                        child: Image.asset("assests/images/training.png",fit: BoxFit.fitWidth),
                                      ),
                                      SizedBox(height: 10,),

                                      Text("Sessions",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 18),),
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

                            ],
                          ),


                        ],
                      ),
                    )

                ),
                            ),
              ),]
          ),);
  }



}