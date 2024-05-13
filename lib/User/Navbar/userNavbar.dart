
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:takhleekish/Artist/Dashboard/artistDashboard.dart';
import 'package:takhleekish/Artist/artistDatabase.dart';
import 'package:takhleekish/Artist/artistPersonal/artist_model.dart';
import 'package:takhleekish/Artist/controllers/artist_controller.dart';
import 'package:takhleekish/User/credentialsFile/User_authentication.dart';
import 'package:takhleekish/User/dashboard/User_Dashboard.dart';
import 'package:takhleekish/User/throughNavBar/artistsProfiles/profiles/artistsProfile.dart';
import 'package:takhleekish/User/throughNavBar/complainsPage/complaints.dart';
import 'package:takhleekish/User/throughNavBar/updatePassword/userUpdatePage.dart';
import 'package:takhleekish/User/throughNavBar/userExhibition/userExhibitionPage.dart';
import 'package:takhleekish/User/throughNavBar/userSessions/selectPage.dart';
import 'package:takhleekish/User/credentialsFile/user_model.dart';
import 'package:takhleekish/User/credentialsFile/user_repository.dart';

import '../../main.dart';
import '../payments/paymentStatus/paymentStatus.dart';
import '../throughNavBar/auctions/ApprovedBids/approvedAuctionPage.dart';
import '../throughNavBar/auctions/wonAuctions/wonProducts.dart';
import '../throughNavBar/feedbackPage/feedback.dart';
import '../throughNavBar/userSessions/communitySessions/communityPage.dart';
class UserNavbar extends StatelessWidget {
  final FirebaseAuth _auth=FirebaseAuth.instance;


  final authrepo = Get.put(User_Auth());

  final UserRepo = Get.put(User_repo());

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
              name=snapshot.data!.name;
              email=snapshot.data!.email;

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
                          child: Image.network(snapshot.data!.url,fit: BoxFit.fitWidth,),

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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>User_dashboard()));

                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.perm_identity_outlined),
                      title: Text("Artists Profiles",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500)),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ArtistsProfiles()));

                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.perm_identity_outlined),
                      title: Text("Exhibition",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500)),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>UserExhibitionPage()));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.update),
                      title: Text("Update Password",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500)),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>UserUpdatePage()));

                      },
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.calendar),
                      title: Text("Personal Sessions",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500)),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>UserSelectPage()));

                      },



                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.calendar),
                      title: Text("Community Sessions",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500)),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CommunitySessionPage()));

                      },



                    ),
                    ListTile(
                      leading: Icon(Icons.point_of_sale),
                      title: Text("Auctions",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500)),
                      onTap: (){

                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ApprovedAuctionPage(email)));

                      },
                    ),

                    ListTile(
                      leading: Icon(Icons.point_of_sale),
                      title: Text("Won Auctions",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500)),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>WonAuctionProducts(email)));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.payment),
                      title: Text("Payment Status",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500)),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentStatus()));
                      },
                    ),
                   
                    ListTile(
                      leading: Icon(Icons.error),
                      title: Text("Complains",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500)),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ComplaintsPage()));
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
          } else {
            // Return Center widget to display CircularProgressIndicator in the center
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<User_model?> getData() async {
    final email = authrepo.firebaseUser.value?.email;
    if (email != null) {
      return await UserRepo.getUserDetail(email);
    }
    return null; // Handle the case where email is null
  }
}
