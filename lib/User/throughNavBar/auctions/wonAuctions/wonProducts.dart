import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:takhleekish/User/throughNavBar/auctions/wonAuctions/auctionProductPayment.dart';

import '../../../../Artist/artistPersonal/artist_authentication.dart';
import '../../../../Artist/artistPersonal/artist_repository.dart';
import '../../../../Artist/auction/auctionModel.dart';
import '../../../../Artist/auction/auctionRepository.dart';
import '../../../../Artist/controllers/artist_controller.dart';
import '../../../Navbar/userNavbar.dart';

class WonAuctionProducts extends StatefulWidget
{
  final String buyer;
  WonAuctionProducts(this.buyer);
  @override
  State<WonAuctionProducts> createState() => _WonAuctionProductsState();
}

class _WonAuctionProductsState extends State<WonAuctionProducts> {
  final controller = Get.put(Artist_Controller());

  final authrepo = Get.put(Artist_Auth());

  final artistRepo = Get.put(Artist_repo());

  final auctionRepo=Get.put(Auction_Repo());

  final FirebaseAuth _auth=FirebaseAuth.instance;

  var email;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: UserNavbar(),
      appBar: AppBar(
        title: const Text("Won Artifacts", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 30)),
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
      body: FutureBuilder(
        future: getAllData(widget.buyer),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {

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
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.separated(
                                itemCount: snapshot.data!.length, // Number of auction (fetch from the database)
                                itemBuilder: (context, index) {

                                  if(snapshot.data![index].paid=='false')
                                  {

                                    return Slidable(
                                      actionPane: SlidableDrawerActionPane(),
                                      actionExtentRatio: 0.25,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(15.0)
                                        ),
                                        child: ListTile(
                                            leading: ClipOval(child:Image.network(snapshot.data![index].url)),
                                            title: Text('Product ${index + 1}'),
                                            subtitle: Text("Name: ${snapshot.data![index].artName}"),
                                            trailing: Text(
                                                "Details"
                                            ),
                                            onTap: ()
                                            {
                                              String docid=snapshot.data![index].id?? "No id";

                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>AuctionProductPayment(snapshot.data![index].bid, snapshot.data![index].artName, snapshot.data![index].url,docid,widget.buyer)));
                                            }
                                        ),
                                      ),
                                    );
                                  }


                                }, separatorBuilder: (BuildContext context, int index) { return const Divider(); },
                              ),
                            ),

                          ],
                        ),
                      ) ,
                    ],
                  )
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

  Future<List<Auction_model>> getAllData(String Buyer) async {
    return await auctionRepo.getWonAuctionProducts(Buyer);
  }
}