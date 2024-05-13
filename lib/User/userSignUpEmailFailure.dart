import 'package:flutter/cupertino.dart';

class UserSignUpFailure {
  final String msg;
  const UserSignUpFailure([this.msg="An unknown error occured. "]);


  factory UserSignUpFailure.code(String code){

    switch(code)
    {
      case 'email-already-in-use':
        return const UserSignUpFailure("An account already extists with this email.");
      case 'Invalid-email':
        return const UserSignUpFailure("Enter Valid Email.");

      default:
        return const UserSignUpFailure();
    }

  }

}