import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:takhleekish/User/UserSessionDatabase/sessionModel.dart';

class Session_UserRepo extends GetxController
{
  static Session_UserRepo get instance=> Get.find();
  final session_db= FirebaseFirestore.instance;


  createSession(Session_User_Model session_Model)
  async {
    await session_db.collection("user_Session")
        .add(session_Model.toJson())
        .whenComplete(() =>
        Get.snackbar("Congratulations", "Session request has been added.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.pink.withOpacity(0.5),
            colorText: Colors.black)
    ).catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());
    });
  }

  Future<List<Session_User_Model>> getUserReqDetails() async
  {
    final snapshot = await session_db.collection("user_Session").get();

      final sessionData = snapshot.docs.map((e) => Session_User_Model.fromSnapshot(e)).toList();
      print(sessionData);

      return sessionData;
    }

  Future<List<Session_User_Model>>getPesronsalSessionReq(String artEmail) async
  {
    final snapshot=await session_db.collection("user_Session").where("Artist_Email",isEqualTo: artEmail).get();
    final auctionStatus=snapshot.docs.map((e) => Session_User_Model.fromSnapshot(e)).toList();
    return auctionStatus;
  }
  Future<List<Session_User_Model>>getApprovedUserSessions(String artEmail) async
  {
    final snapshot=await session_db.collection("user_Session").where("User_Email",isEqualTo: artEmail).get();
    final auctionStatus=snapshot.docs.map((e) => Session_User_Model.fromSnapshot(e)).toList();
    return auctionStatus;
  }


}