import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takhleekish/Artist/artistPersonal/artist_model.dart';

class Artist_repo extends GetxController{
  static Artist_repo get instance=> Get.find();
  final artist_db= FirebaseFirestore.instance;

  createUser(Artist_model artists)
  async {

    await artist_db.collection("Artists").add(artists.toJson()).whenComplete(() => Get.snackbar("Congratulations", "Your account has been created.",
        snackPosition:SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green),
    ).catchError((error,stackTrace){
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition:SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());

    });
  }

  Future<Artist_model> getArtistDetail(String email) async
  {
    final snapshot=await artist_db.collection("Artists").where("Email",isEqualTo: email).get();
    final artistData=snapshot.docs.map((e) => Artist_model.fromSnapshot(e)).single;
    return artistData;
  }
  Future<List<Artist_model>> getAllArtistDetail() async
  {
    final snapshot=await artist_db.collection("Artists").get();
    final artistData=snapshot.docs.map((e) => Artist_model.fromSnapshot(e)).toList();
    return artistData;
  }

}