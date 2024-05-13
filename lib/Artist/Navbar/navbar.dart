
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:takhleekish/Artist/throughNavbar/AnalyticsPage/analytics.dart';
import 'package:takhleekish/Artist/Dashboard/artistDashboard.dart';
import 'package:takhleekish/Artist/artistDatabase.dart';
import 'package:takhleekish/Artist/artistPersonal/artist_model.dart';
import 'package:takhleekish/Artist/controllers/artist_controller.dart';
import 'package:takhleekish/Artist/throughNavbar/ComplainsPage/artistComplainsPage.dart';
import 'package:takhleekish/Artist/throughNavbar/updatePassword/artistUpdatePassword.dart';
import 'package:takhleekish/main.dart';

import '../artistPersonal/artist_authentication.dart';
import '../artistPersonal/artist_repository.dart';
import '../throughDashboard/ArtistAuction/auctionStatus.dart';
import '../throughDashboard/Sessions/personalSessions/personalSessions.dart';
import '../throughDashboard/Sessions/userSessionRequests/userRequestPage.dart';

class Navbar extends StatelessWidget {
  final controller = Get.put(Artist_Controller());

  final authrepo = Get.put(Artist_Auth());

  final artistRepo = Get.put(Artist_repo());

  final FirebaseAuth _auth=FirebaseAuth.instance;

  var email;

  var name;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              Artist_model artistModel = snapshot.data!;
              name=snapshot.data!.name;
              email=snapshot.data!.email;
              print(artistModel.url);
              print('aslkjad');
          //     Text("$email"),
          // Text("$name"),

              return Container(
                color: Colors.white,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    UserAccountsDrawerHeader(accountName: Text("  $name",style: TextStyle(fontWeight: FontWeight.w500),),
                        accountEmail: Text("   $email",style: TextStyle(fontWeight: FontWeight.w500),),
                    currentAccountPicture: CircleAvatar(
                      child: ClipOval(
                          child: Image.network(snapshot.data!.url),

                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        image: NetworkImage(
                       'https://media.istockphoto.com/id/887755698/photo/watercolor-textured-background.webp?b=1&s=170667a&w=0&k=20&c=aiUOD1FgS1Q0CHn6kwFy_COsCaTCWtZ3ZaZYU251Io8=' ),
                        fit: BoxFit.cover,
                      )
                    ),),
                    ListTile(
                      leading: Icon(Icons.home),
                      title: Text("Dashboard",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500)),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ArtistDashboard()));
                      },



                    ),
                    ListTile(
                      leading: Icon(Icons.update),
                      title: Text("Update Password",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500)),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ArtistUpdatePassword()));
                      },



                    ),
                    ListTile(
                      leading: Icon(Icons.query_stats),
                           title: Text("Analytics",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500)),
                         onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ArtistAnalyticsPage()));
                       },
                    ),
                    ListTile(
                      leading: Icon(Icons.update),
                      title: Text("Auction Status",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500)),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AuctionStatus()));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.request_page_outlined),
                      title: Text("Session Requests",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500)),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>UserRequestPage()));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.class_outlined),
                      title: Text("Personal Sessions",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500)),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>PersonalUserSessions()));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.exit_to_app),
                      title: Text("Logout",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500)),
                      onTap: (){
                      _auth.signOut();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
                      },
                    )

                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text('User not found');
            } else {
              return Text('Something went wrong');
            }
          }
          else {
            // Return Center widget to display CircularProgressIndicator in the center
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<Artist_model?> getData() async {
    final email = authrepo.firebaseUser.value?.email;
    if (email != null) {
      return await artistRepo.getArtistDetail(email);
    }
    return null; // Handle the case where email is null
  }
}
