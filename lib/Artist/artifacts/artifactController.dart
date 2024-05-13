import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:takhleekish/Artist/artifacts/artifactRepository.dart';
import 'package:takhleekish/Artist/artistPersonal/artist_authentication.dart';
import 'package:takhleekish/Artist/artistPersonal/artist_model.dart';
import 'package:takhleekish/Artist/artistPersonal/artist_repository.dart';
import 'artifactModel.dart';

class Artifact_Controller extends GetxController{
  static Artifact_Controller get instance => Get.find();
  final Artifact_category=TextEditingController();
  final Artifact_name=TextEditingController();
  final Artifact_price=TextEditingController();
  final Artifact_desc=TextEditingController();
  final  Artist_id=TextEditingController();
  late final String Artifact_url;
  final artifactRepo = Get.put(Artifact_repo());
  void setArtistId(String artistId) {
    Artist_id.text = artistId;
  }
  Future<void> createArtifactt(Artifact_model artifact_model)
  async {
    await artifactRepo.createArtifact(artifact_model);
  }
}