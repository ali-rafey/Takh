import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takhleekish/User/credentialsFile/user_model.dart';

class User_repo extends GetxController
{
static User_repo get instance => Get.find();
final user_db= FirebaseFirestore.instance;

createUser(User_model users)
async {

  await user_db.collection("Users").add(users.toJson()).whenComplete(() => Get.snackbar("Congratulations", "Your account has been created.",
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

Future<void> updatePassword(User_model user_model)
async {
  await user_db.collection("Users").doc(user_model.id).update(user_model.toJson());
}
Future<User_model> getUserDetail(String email) async
{
  final snapshot=await user_db.collection("Users").where("Email",isEqualTo: email).get();
  final UserData=snapshot.docs.map((e) => User_model.fromSnapshot(e)).single;
  return UserData;
}
Future<List<User_model>> getAllUserDetail() async
{
  final snapshot=await user_db.collection("Users").get();
  final UserData=snapshot.docs.map((e) => User_model.fromSnapshot(e)).toList();
  return UserData;
}
}