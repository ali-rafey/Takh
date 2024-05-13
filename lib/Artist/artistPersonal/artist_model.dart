import 'package:cloud_firestore/cloud_firestore.dart';

class Artist_model{
  final String? id;
  final String name;
  final String email;
  final String cnic;
  final String pass;
  final String url;

  const Artist_model(
  {
  this.id,
  required this.name,
  required this.email,
  required this.cnic,
  required this.pass,
    required this.url,
  });
  toJson(){
    return{
      'Name':name,
      'Cnic':cnic,
      'Email':email,
      'Password':pass,
      'Dp':url,
    };}

    factory Artist_model.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> documentSnapshot)
    {
      final data=documentSnapshot.data()!;
        return Artist_model(
            id: documentSnapshot.id,
            name: data["Name"], email: data["Email"], cnic: data["Cnic"], pass: data["Password"], url: data["Dp"]);
    }


}