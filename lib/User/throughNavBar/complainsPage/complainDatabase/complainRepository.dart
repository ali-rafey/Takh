import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takhleekish/User/throughNavBar/complainsPage/complainDatabase/complainModel.dart';

class ComplainRepo extends GetxController
{
  static ComplainRepo get instance=> Get.find();
  final artifact_db= FirebaseFirestore.instance;

  createArtifact(ComplainModel complain_model)
  async {
    await artifact_db.collection("Complains").add(complain_model.toJson()).catchError((error,stackTrace){
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition:SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());

    });
  }
  Future<List<ComplainModel>> getSpecificComplainDetail(String UserId) async
  {
    final snapshot=await artifact_db.collection("Complains").where("User_Email",isEqualTo: UserId).get();
    final artifactData=snapshot.docs.map((e) => ComplainModel.fromSnapshot(e)).toList();
    return artifactData;
  }

  Future<List<ComplainModel>> getAllComplainDetail() async
  {
    final snapshot=await artifact_db.collection("Complains").get();
    final artifactData=snapshot.docs.map((e) => ComplainModel.fromSnapshot(e)).toList();
    return artifactData;
  }

}