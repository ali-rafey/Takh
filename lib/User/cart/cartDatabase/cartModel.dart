import 'package:cloud_firestore/cloud_firestore.dart';

class Cart_model{
  final String? id;
  final String ArtistId;
  final String name;
  final String price;
  final String category;
  final String description;
  final String productDocId;
  final String url;
  const Cart_model(
      {
        this.id,
        required this.name,
        required this.ArtistId,
        required this.price,
        required this.category,
        required this.productDocId,
        required this.description,
        required this.url
      });
  toJson(){
    return{
      'Name':name,
      'Category':category,
      'ProductDocId':productDocId,
      'Price':price,
      'Detail':description,
      'User_ID':ArtistId,
      'Url':url,
    };}

  factory Cart_model.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> documentSnapshot)
  {
    final data=documentSnapshot.data()!;
    return Cart_model(
      id: documentSnapshot.id,
      name: data["Name"], price: data["Price"], category: data["Category"], description: data["Detail"], ArtistId: data["User_ID"], url: data['Url'], productDocId:data['ProductDocId'],);
  }
}