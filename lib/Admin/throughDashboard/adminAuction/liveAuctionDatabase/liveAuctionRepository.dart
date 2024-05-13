import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takhleekish/Admin/throughDashboard/adminAuction/liveAuctionDatabase/liveAuctionModel.dart';
import 'package:takhleekish/Artist/auction/auctionModel.dart';

class live_Auction_Repo extends GetxController{
  static live_Auction_Repo get instance=> Get.find();
  final auction_db= FirebaseFirestore.instance;

  createAuction(Live_Auction_model auction_model)
  async {
    await auction_db.collection("Live_Auction").add(auction_model.toJson()).catchError((error,stackTrace){
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition:SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());
    });
    }

  Future<List<Live_Auction_model>>getPesronsalAuctionStatus(String artName) async
  {
    final snapshot=await auction_db.collection("Live_Auction").where("User_ID",isEqualTo: artName).get();
    final auctionStatus=snapshot.docs.map((e) => Live_Auction_model.fromSnapshot(e)).toList();
    return auctionStatus;
  }
  Future<Live_Auction_model>getPesronsalAuction(String artName) async
  {
    final snapshot=await auction_db.collection("Live_Auction").where("Name",isEqualTo: artName).get();
    final auctionStatus=snapshot.docs.map((e) => Live_Auction_model.fromSnapshot(e)).single;
    return auctionStatus;
  }
  Future<List<Live_Auction_model>> getAllAuctionDetail() async
  {
    final snapshot=await auction_db.collection("Live_Auction").get();
    final artifactData=snapshot.docs.map((e) => Live_Auction_model.fromSnapshot(e)).toList();
    return artifactData;
  }
}