
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Auction_model{
  final String? id;
  final String ArtistId;
  final String artName;
  final String bid;
  final String startingTime;
  final String auctionDate;
  final String endingTime;
  final String url;
  final String status;
  final String checkAuc;
  final String checkBidStatus;
  final String isLive;
  final String liveBaseBid;
  final String buyer;
  final String paid;
  const Auction_model(
      {
        this.id,
        required this.artName,
        required this.ArtistId,
        required this.bid,
        required this.startingTime,
        required this.endingTime,
        required this.auctionDate,
        required this.url,
        required this.checkAuc,
        required this.status,
        required this.checkBidStatus,
        required this.isLive,
        required this.liveBaseBid,
        required this.buyer,
        required this.paid,
      });
  toJson(){
    return{
      'Name':artName,
      'Starting_Time':startingTime,
      'Auction_Date':auctionDate,
      'Bid':bid,
      'Ending_Time':endingTime,
      'Artist_ID':ArtistId,
      'Url':url,
      'Status':status,
      'Check':checkAuc,
      'BidStatus':checkBidStatus,
      'isLive':isLive,
      'liveBaseBid':liveBaseBid,
      'Buyer':buyer,
      'paid':paid,
    };}

  factory Auction_model.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> documentSnapshot)
  {
    final data=documentSnapshot.data()!;
    return Auction_model(
      id: documentSnapshot.id,
      artName: data["Name"], startingTime: data["Starting_Time"],
      bid: data["Bid"], endingTime: data["Ending_Time"],
      ArtistId: data["Artist_ID"], url: data['Url'],
      auctionDate: data["Auction_Date"],  status: data["Status"],
      checkAuc: data["Check"], checkBidStatus: 'BidStatus', isLive: data["isLive"], liveBaseBid: data["liveBaseBid"], buyer:data["Buyer"], paid:data["paid"],);
  }


}