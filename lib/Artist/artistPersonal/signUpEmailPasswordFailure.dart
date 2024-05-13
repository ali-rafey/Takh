import 'package:flutter/cupertino.dart';

class SignUpFailure {
  final String msg;
  const SignUpFailure([this.msg="An unknown error occured. "]);


  factory SignUpFailure.code(String code){

    switch(code)
    {
      case 'email-already-in-use':
        return const SignUpFailure("An account already extists with this email.");

      default:
        return const SignUpFailure();
    }

  }
  
}