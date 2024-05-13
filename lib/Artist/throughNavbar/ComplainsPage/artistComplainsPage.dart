import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArtistComplainsPage extends StatefulWidget{
  @override
  State<ArtistComplainsPage> createState() => _ArtistComplainsPageState();
}

class _ArtistComplainsPageState extends State<ArtistComplainsPage> {
  TextEditingController _complaintController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                padding: EdgeInsets.all(16.0),
                constraints: BoxConstraints(maxWidth: 400),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 200,),
                    Text(

                      'We apologize for any inconvenience!',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue, // Change border color to red for complaints
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextField(
                        controller: _complaintController,
                        maxLines: 5,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(8.0),
                          hintText: 'Enter your complaint here',
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 200,
                      height: 50,
                      child:Container(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed:()   {
                            String complaint = _complaintController.text;
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
                              child:  Text('Submit Complaint',style:TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ),

                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
  void dispose() {
    _complaintController.dispose();
    super.dispose();
  }
}