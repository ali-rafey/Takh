import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:takhleekish/Artist/Dashboard/artistDashboard.dart';
import 'package:takhleekish/Artist/throughDashboard/postArtifact/postArtifacts.dart';

class VerifyProduct extends StatelessWidget
{
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
                    width: 400,
                    height: 530,
                    child:Image.asset("assests/images/contract.png"
                      ,fit: BoxFit.fitHeight,),
                  ),
                ),

                SizedBox(
                  height:screenHeight*0.06,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 60,
                      child: Center(
                        child: ElevatedButton(onPressed:()
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>PostArtifact()));

                        }, child:Center(child: Center(child: Text("Approve",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize:20),),)),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)
                              )
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width:10,),
                    Container(
                      width: 150,
                      height: 60,
                      child: Center(
                        child: ElevatedButton(onPressed:() {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ArtistDashboard()));
                        }, child:Center(child: Center(child:Text("Reject",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize:20),) )),

                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)
                              )
                          ),
                        ),
                      ),
                    ),],
                ),

              ],
            ),
          )

        ],
      ),
    ),
  );
  }

}