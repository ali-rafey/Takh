import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:takhleekish/Artist/artifacts/artifactRepository.dart';
import 'package:takhleekish/User/payments/database/model/model.dart';
import 'package:takhleekish/User/payments/database/repository/Repository.dart';

class Payment_Controller extends GetxController{
  static Payment_Controller get instance => Get.find();
  final  Artist_id=TextEditingController();
  late final String payment_url;
  final payment_repo = Get.put(Payment_repo());
  void setArtistId(String artistId) {
    Artist_id.text = artistId;
  }
  Future<void> createReceipt(Payment_model payment_model)
  async {
    await payment_repo.createArtifact(payment_model);
  }
}