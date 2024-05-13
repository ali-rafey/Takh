import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takhleekish/Artist/sessionDatabase/artistSessionModel.dart';

class ArtistSessionRepo extends GetxController
{
  static ArtistSessionRepo get instance=> Get.find();
  final session_db= FirebaseFirestore.instance;


  createSession(ArtistSessionModel session_Model)
  async {
    await session_db.collection("Artist_Session")
        .add(session_Model.toJson())
        .whenComplete(() =>
        Get.snackbar("Congratulations", "Session request has been added.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.white),
    ).catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());
    });
  }

  Future<List<ArtistSessionModel>> getUserReqDetails() async
  {
    final snapshot = await session_db.collection("Artist_Session").get();

    final sessionData = snapshot.docs.map((e) => ArtistSessionModel.fromSnapshot(e)).toList();
    print(sessionData);

    return sessionData;
  }

  Future<List<ArtistSessionModel>>getPesronsalSessionReq(String artEmail) async
  {
    final snapshot=await session_db.collection("Artist_Session").where("Artist_Email",isEqualTo: artEmail).get();
    final auctionStatus=snapshot.docs.map((e) => ArtistSessionModel.fromSnapshot(e)).toList();
    return auctionStatus;
  }
  Future<List<ArtistSessionModel>>getallSession() async
  {
    final snapshot=await session_db.collection("Artist_Session").get();
    final auctionStatus=snapshot.docs.map((e) => ArtistSessionModel.fromSnapshot(e)).toList();
    return auctionStatus;
  }



}