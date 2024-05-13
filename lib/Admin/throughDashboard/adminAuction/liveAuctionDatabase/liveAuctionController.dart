import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takhleekish/Admin/throughDashboard/adminAuction/liveAuctionDatabase/liveAuctionModel.dart';
import 'package:takhleekish/Admin/throughDashboard/adminAuction/liveAuctionDatabase/liveAuctionRepository.dart';
import 'package:takhleekish/Artist/auction/auctionModel.dart';
import 'package:takhleekish/Artist/auction/auctionRepository.dart';

class Live_Auction_Controller extends GetxController{
  static Live_Auction_Controller get instance => Get.find();
  final Art_bid=TextEditingController();
  final  User_id=TextEditingController();
  late final String img_url;
  late final TimeOfDay endtime;
  final liveAuctionRepo = Get.put(live_Auction_Repo());
  void setArtistId(String artistId) {
    User_id.text = artistId;
  }
  Future<void> createLiveAuction(Live_Auction_model auction_model)
  async {
    await liveAuctionRepo.createAuction(auction_model);
  }



}