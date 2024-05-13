import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takhleekish/Artist/Dashboard/artistDashboard.dart';
import 'package:takhleekish/User/dashboard/User_Dashboard.dart';

import '../../Admin/adminDashboard/dashboard.dart';

class ArtitstLoginController extends GetxController {
  final TextEditingController Aremail = TextEditingController();
  final TextEditingController Arpass = TextEditingController();
  RxString errorMessage = ''.obs;

  // Callback to handle navigation
  late VoidCallback onLoginSuccess;

  // Setter for the callback
  void setOnLoginSuccess(VoidCallback callback) {
    onLoginSuccess = callback;
  }

  Future<void> login() async {
    try {
      if ( Aremail.text.trim() == 'admin123@gmail.com' && Arpass.text.trim() == 'admin123') {
        // Admin login successful on the web
        onLoginSuccess(); // Call the callback
        Get.offAll(() => AdminDashboard());
        Get.snackbar(
          'Login Successful',
          'Welcome, Admin!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey,
        );
      } else {
        // For regular users or non-web admin login, perform Firebase authentication
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: Aremail.text.trim(),
          password: Arpass.text.trim(),
        );
        bool isArtist = await isArtistUser(userCredential.user?.email);
        if (isArtist){
          // Check if the user is a regular user (you can replace this condition with your user identification logic)
          if (userCredential.user?.uid != null && userCredential.user?.uid != 'admin_uid') {
            // Regular user login successful
            Get.offAll(() => ArtistDashboard());
            Get.snackbar(
              'Login Successful',
              'Welcome, Artist!',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.grey,
            );
          } else {
            // Handle other cases if needed
          }
        }
        else{
          errorMessage.value = 'Incorrect Credentials';
          Future.delayed(Duration(seconds: 3), () {
            errorMessage.value = '';
          });

        }

      }
    } catch (e) {
      // Handle login errors
      print('Login error: $e');

      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') {
          errorMessage.value = 'Incorrect email';
          Future.delayed(Duration(seconds: 3), () {
            errorMessage.value = '';
          });
        } else if (e.code == 'wrong-password') {
          errorMessage.value = 'Incorrect password';
          Future.delayed(Duration(seconds: 3), () {
            errorMessage.value = '';
          });
        } else {
          errorMessage.value = 'Login failed. Please try again.';
          Future.delayed(Duration(seconds: 3), () {
            errorMessage.value = '';
          });
        }
      } else {
        errorMessage.value = 'An unexpected error occurred.';
        Future.delayed(Duration(seconds: 3), () {
          errorMessage.value = '';
        });
      }
      rethrow;
    }
  }
  Future<bool> isArtistUser(String? email) async {
    if (email == null) {
      return false;
    }
    // Assuming you have a "artists" collection in Firestore
    // and each artist document has a field "uid" with the artist's UID

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Artists')
          .where('Email', isEqualTo: email)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking if user is an artist: $e');
      return false;
    }
  }
}