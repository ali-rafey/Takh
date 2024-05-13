import 'package:cloud_firestore/cloud_firestore.dart';

class ComplainModel
{
  final String? id;
  final String complain;
  final String userEmail;
  final String url;

  ComplainModel({ this.id, required this.complain,required this.userEmail,required this.url});
  toJson(){
    return{
      'User_Email':userEmail,
      'Complain':complain,
      'Url':url,
    };}
  factory ComplainModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> documentSnapshot)
  {
    final data=documentSnapshot.data()!;
    return ComplainModel(
        id: documentSnapshot.id,complain: data["Complain"], userEmail: data["User_Email"], url: data["Url"],

    );
  }

  }
