import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takhleekish/Artist/artifacts/artifactModel.dart';
import 'package:takhleekish/Artist/artistPersonal/artist_model.dart';

class Artifact_repo extends GetxController
{
  static Artifact_repo get instance=> Get.find();
  final artifact_db= FirebaseFirestore.instance;

  createArtifact(Artifact_model artifact_model)
  async {
    await artifact_db.collection("Artifacts").add(artifact_model.toJson()).whenComplete(() => Get.snackbar("Congratulations", "Artifact has been added.",
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

  Future<Artifact_model> getArtifacttDetail(String ArtistId) async
  {
    final snapshot=await artifact_db.collection("Artifacts").where("Artist_ID",isEqualTo: ArtistId).get();
    final artifactData=snapshot.docs.map((e) => Artifact_model.fromSnapshot(e)).single;
    return artifactData;
  }
  Future<List<Artifact_model>> getSpecificArtistArtifacttDetail(String ArtistId) async
  {
    final snapshot=await artifact_db.collection("Artifacts").where("Artist_ID",isEqualTo: ArtistId).get();
    final artifactData=snapshot.docs.map((e) => Artifact_model.fromSnapshot(e)).toList();
    return artifactData;
  }

  Future<List<Artifact_model>> getAllArtifacttDetail() async
  {
    final snapshot=await artifact_db.collection("Artifacts").get();
    final artifactData=snapshot.docs.map((e) => Artifact_model.fromSnapshot(e)).toList();
    return artifactData;
  }

}