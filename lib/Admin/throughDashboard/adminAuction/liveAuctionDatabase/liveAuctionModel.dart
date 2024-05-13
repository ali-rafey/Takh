
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Live_Auction_model{
  final String? id;
  final String userID;
  final String bidAmount;
  final String url;
  final String endingtime;

  const Live_Auction_model(
      {
        this.id,
        required this.bidAmount,
        required this.userID,
        required this.url,
        required this.endingtime,
      });
  toJson(){
    return{
      'Name':bidAmount,
      'User_ID':userID,
      'Url':url,
      'EndingTime':endingtime,
    };}

  factory Live_Auction_model.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> documentSnapshot)
  {
    final data=documentSnapshot.data()!;
    return Live_Auction_model(
      id: documentSnapshot.id,
      bidAmount: data["Name"],
      url: data['Url'], userID: data["User_ID"], endingtime: data['EndingTime']);
      }


}