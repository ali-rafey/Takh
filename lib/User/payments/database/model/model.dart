import 'package:cloud_firestore/cloud_firestore.dart';

class Payment_model{
  final String? id;

  final String UserId;
  final String reciept;
  final String bill;
  final String status;
  final String paymentCheck;
  const Payment_model(
      {
        this.id,

        required this.UserId,
        required this.bill,
        required this.reciept,
        required this.status,
        required this.paymentCheck,
      });
  toJson(){
    return{
      'Bill':bill,
      'Reciept':reciept,
      'status':status,
      'UserId':UserId,
      'Check':paymentCheck,
    };}

  factory Payment_model.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> documentSnapshot)
  {
    final data=documentSnapshot.data()!;
    return Payment_model(
      id: documentSnapshot.id,
       bill:data["Bill"], reciept: data["Reciept"], status: data["status"], paymentCheck: data["Check"], UserId: data["UserId"],
    );
  }


}