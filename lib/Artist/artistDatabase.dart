import 'package:cloud_firestore/cloud_firestore.dart';

class ArtistDataBase {
  final String uid;
  ArtistDataBase({required this.uid});
  var email;
  var name;
  final collection=FirebaseFirestore.instance.collection("Artists");

  Stream<QuerySnapshot> get users{

    return collection.snapshots();
  }
  Future getCurrentArtist() async
  {
    DocumentSnapshot documentSnapshot=await collection.doc(uid).get();
    email=documentSnapshot.get("Email");
    name=documentSnapshot.get("Name");
    return {email,name};


  }
}