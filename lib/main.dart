import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takhleekish/Admin/adminDashboard/dashboard.dart';
import 'package:takhleekish/Artist/artistPersonal/art_signup.dart';
import 'package:takhleekish/Artist/Navbar/navbar.dart';
import 'package:takhleekish/Artist/Dashboard/artistDashboard.dart';
import 'package:takhleekish/Artist/throughDashboard/checkUser/verifyGmail.dart';
import 'package:takhleekish/splashScreen/Splash.dart';
import 'package:takhleekish/User/dashboard/User_Dashboard.dart';
import 'package:takhleekish/User/credentialsFile/User_authentication.dart';
import 'package:takhleekish/User/dashboard/detailProductPage.dart';
import 'package:takhleekish/User/forgot_Password/forgotPage.dart';
import 'package:takhleekish/User/forgot_Password/resetPassword.dart';
import 'package:takhleekish/User/Navbar/userNavbar.dart';
import 'package:takhleekish/User/userPersonal/user_login.dart';
import 'package:takhleekish/User/userPersonal/user_signup.dart';
import 'package:takhleekish/Artist/artistPersonal/art_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:takhleekish/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Artist/throughDashboard/ArtistAuction/auction.dart';
import 'Artist/throughDashboard/postArtifact/verifyProduct.dart';
import 'Artist/throughNavbar/AnalyticsPage/analytics.dart';
import 'Artist/throughDashboard/postArtifact/postArtifacts.dart';
import 'User/payments/paymentPage/paymentPage.dart';
import 'User/throughNavBar/auctions/ApprovedBids/approvedBidPage.dart';
// import 'User/throughNavBar/auctions/availableBids/userAuctionPage.dart';
import 'User/throughNavBar/feedbackPage/feedback.dart';
import 'User/throughNavBar/userExhibition/detailExhibationPage.dart';
import 'User/throughNavBar/userExhibition/userExhibitionPage.dart';
import 'User/throughNavBar/userSessions/selectPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(User_Auth()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        // ignore: deprecated_member_use
        backgroundColor: Color(0xfff77062),
      ),
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body:Stack(
        children: [
          Container(
            width: double.infinity,
            height: 880,
            child: Image.asset("assests/images/dbpic2.jpeg"
              ,fit: BoxFit.fitHeight,),
            //add background image here
          ),
          Center(
              child:Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0,bottom: 20.0),
                    child: Container(
                        width: 320,
                        height: 320,
                        child: Image.asset("assests/images/homeScreenPic.png")),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Container(
                      width: 180,
                      height: 180,
                      child: ElevatedButton(onPressed:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>User_login()),);

                      }, child:Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right:15.0,left: 15.0,top: 17),
                            child: Image.asset("assests/images/avatar.png"),
                          ),
                          Text("User",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 18),),
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
                  Padding(
                    padding: const EdgeInsets.only(top: 15,bottom: 18),
                    child: Container(
                      width: 180,
                      height: 180,
                      child: ElevatedButton(onPressed:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Artist_login()),);
                      }, child:Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right:15.0,left: 15.0,top: 17),
                            child: Image.asset("assests/images/artist.png"),
                          ),
                          Text("Artist",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 18),),
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

          ),
        ],
      )



    );
  }
}
//hello trying