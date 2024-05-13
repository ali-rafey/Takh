import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takhleekish/User/credentialsFile/User_authentication.dart';

class UserMailVerifyController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    sendVerificationEmail();
  }

  Future<void> sendVerificationEmail() async {
    try{
      await  User_Auth.instance.SendUserEmailVerification();
    }catch(e)
    {
      Get.snackbar("Error", "Enter the valid Email.",
          snackPosition:SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.red);
    }

  }

  void setTimerForAutoRedirect() {

  }

  void manuallyCheckEmailVerification() {

  }
}