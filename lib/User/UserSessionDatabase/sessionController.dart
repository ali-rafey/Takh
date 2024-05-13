import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takhleekish/User/UserSessionDatabase/sessionModel.dart';
import 'package:takhleekish/User/UserSessionDatabase/sessionRepository.dart';

class sessionController extends GetxController{
  static sessionController get instance => Get.find();
  final artTitle=TextEditingController();
  final userMail=TextEditingController();
  DateTime? sessionDate;
  TimeOfDay? session_startingTime;

  final  artistMail=TextEditingController();
  final sessionRepo = Get.put(Session_UserRepo());
  void setArtistId(String artistId) {
    artistMail.text = artistId;
  }
  Future<void> createSession(Session_User_Model session_user_model)
  async {
    await sessionRepo.createSession(session_user_model);
  }


}