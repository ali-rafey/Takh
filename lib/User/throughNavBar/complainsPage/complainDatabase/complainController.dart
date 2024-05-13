import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:takhleekish/User/throughNavBar/complainsPage/complainDatabase/complainModel.dart';
import 'package:takhleekish/User/throughNavBar/complainsPage/complainDatabase/complainRepository.dart';

class ComplainController extends GetxController
{
  static ComplainController get instance => Get.find();
  final Complain=TextEditingController();
  final  User_id=TextEditingController();
  final complainRepo = Get.put(ComplainRepo());
  void setArtistId(String artistId) {
    User_id.text = artistId;
  }
  Future<void> createComplain(ComplainModel complainModel)
  async {
    await complainRepo.createArtifact(complainModel);
  }
}