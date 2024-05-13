import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takhleekish/Artist/artifacts/artifactModel.dart';

import '../model/model.dart';

class Payment_repo extends GetxController
{
  static Payment_repo get instance=> Get.find();
  final payment_db= FirebaseFirestore.instance;

  createArtifact(Payment_model artifact_model)
  async {
    await payment_db.collection("Receipt").add(artifact_model.toJson()).whenComplete(() => Get.snackbar("Congratulations", "Receipt has been uploaded.",
        snackPosition:SnackPosition.BOTTOM,
        backgroundColor: Colors.pink.withOpacity(0.5),
        colorText: Colors.black)
    ).catchError((error,stackTrace){
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition:SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());

    });
  }

  Future<Payment_model> getReceiptDetail(String ArtistId) async
  {
    final snapshot=await payment_db.collection("Receipt").where("UserId",isEqualTo: ArtistId).get();
    final artifactData=snapshot.docs.map((e) => Payment_model.fromSnapshot(e)).single;
    return artifactData;
  }
  Future<List<Payment_model>> getSpecificReceiptDetail(String ArtistId) async
  {
    final snapshot=await payment_db.collection("Receipt").where("UserId",isEqualTo: ArtistId).get();
    final artifactData=snapshot.docs.map((e) => Payment_model.fromSnapshot(e)).toList();
    return artifactData;
  }

  Future<List<Payment_model>> getAllReceiptDetail() async
  {
    final snapshot=await payment_db.collection("Receipt").get();
    final artifactData=snapshot.docs.map((e) => Payment_model.fromSnapshot(e)).toList();
    return artifactData;
  }

}