import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:takhleekish/User/cart/cartDatabase/cartRepository.dart';

import 'cartModel.dart';

class CartController extends GetxController
{
  static CartController get instance => Get.find();
  final Artifact_category=TextEditingController();
  final Artifact_name=TextEditingController();
  final Artifact_price=TextEditingController();
  final Artifact_desc=TextEditingController();
  final  Artist_id=TextEditingController();
  late final String Artifact_url;
  final cartRepo = Get.put(CartRepo());
  void setArtistId(String artistId) {
    Artist_id.text = artistId;
  }
  Future<void> createCart(Cart_model cart_model)
  async {
    await cartRepo.createCart(cart_model);
  }
}