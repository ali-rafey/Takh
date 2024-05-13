import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takhleekish/User/credentialsFile/User_authentication.dart';
import 'package:takhleekish/User/credentialsFile/user_model.dart';
import 'package:takhleekish/User/credentialsFile/user_repository.dart';

class User_Controller extends GetxController{
static User_Controller get instance => Get.find();
final Usemail=TextEditingController();
final Usname=TextEditingController();
final Uspass=TextEditingController();
final Uscnic=TextEditingController();
late final String User_url;

final userRepo = Get.put(User_repo());

Future<bool> registerUser(String email, String pass) async {
 try {
  await User_Auth.instance.createUserWithEmailandPass(email, pass);
  return true; // Registration successful
 } catch (error) {
  print("Error during User registration: $error");
  return false; // Registration failed
 }
}

Future<void> createUser(User_model user_model)
async {
 await userRepo.createUser(user_model);
}
updatePassword(User_model password)async{
 await userRepo.updatePassword(password);
}
}