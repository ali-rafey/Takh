import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:takhleekish/Artist/artistPersonal/artist_authentication.dart';
import 'package:takhleekish/Artist/artistPersonal/artist_model.dart';
import 'package:takhleekish/Artist/artistPersonal/artist_repository.dart';

class Artist_Controller extends GetxController{
  static Artist_Controller get instance => Get.find();
  final Aremail=TextEditingController();
  final Arname=TextEditingController();
  final Arpass=TextEditingController();
  final Arcnic=TextEditingController();
  late final String Artist_url;
  final artistRepo = Get.put(Artist_repo());

  Future<void> createArtist(Artist_model artist_model)
  async {
    await artistRepo.createUser(artist_model);
  }
  Future<bool> registerArtist(String email, String pass) async {
    try {
      await Get.put(Artist_Auth()).createArtistWithEmailandPass(email, pass);
      return true; // Registration successful
    } catch (error) {
      print("Error during artist registration: $error");
      return false; // Registration failed
    }
  }
}