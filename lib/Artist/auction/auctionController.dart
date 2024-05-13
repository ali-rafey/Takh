import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takhleekish/Artist/auction/auctionModel.dart';
import 'package:takhleekish/Artist/auction/auctionRepository.dart';

class Auction_Controller extends GetxController{
  static Auction_Controller get instance => Get.find();
  final Art_name=TextEditingController();
  final Art_bid=TextEditingController();
  late final String status;
  DateTime? auctDate;
  TimeOfDay? Art_startingTime;
  TimeOfDay? Art_endingTime;
  final  Artist_id=TextEditingController();
  late final String img_url;
  late final String check;
  final auctionRepo = Get.put(Auction_Repo());
  void setArtistId(String artistId) {
    Artist_id.text = artistId;
  }
  Future<void> createAuction(Auction_model auction_model)
  async {
    await auctionRepo.createAuction(auction_model);
  }



}