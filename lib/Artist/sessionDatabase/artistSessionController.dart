import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takhleekish/Artist/sessionDatabase/artistSessionModel.dart';

import 'artistSessionRepository.dart';

class ArtistSessionController extends GetxController{
  static ArtistSessionController get instance => Get.find();
  final artTitle=TextEditingController();
  DateTime? sessionDate;
  TimeOfDay? session_startingTime;

  final  artistMail=TextEditingController();
  final sessionRepo = Get.put(ArtistSessionRepo());
  void setArtistId(String artistId) {
    artistMail.text = artistId;
  }
  Future<void> createSession(ArtistSessionModel session_user_model)
  async {
    await sessionRepo.createSession(session_user_model);
  }
}