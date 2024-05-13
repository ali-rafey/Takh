import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailExhibitionPage extends StatelessWidget {
  final DocumentSnapshot exhibition;

  DetailExhibitionPage({required this.exhibition});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    String venue = exhibition['venue'];
    String date = exhibition['date'];
    String time = exhibition['time'];

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 880,
            child: Image.asset(
              "assests/images/dbpic2.jpeg",
              fit: BoxFit.fitHeight,
            ),
          ),
          Container(
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.1),
                Center(
                  child: Container(
                    width: 300,
                    height: 300,
                    child: Image.asset("assests/images/homeScreenPic.png"),
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                Text(
                  "Venue:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  venue,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  "Date:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  date,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  "Time:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  time,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: screenHeight * 0.04),

                Container(
                  width: 200,
                  height: 50,
                  child:Container(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed:() {
                        _launchMaps(venue); // Launch Google Maps with the venue as the destination
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
                          child:  Row(
                            children: [
                              SizedBox(width: 18),
                              FaIcon(FontAwesomeIcons.mapLocationDot, color: Colors.black),
                              SizedBox(width: 25),
                              Text(
                                "Location",
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _launchMaps(String destination) async {
    final googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$destination';
    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }
}
