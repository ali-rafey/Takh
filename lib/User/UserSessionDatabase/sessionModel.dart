import 'package:cloud_firestore/cloud_firestore.dart';

class Session_User_Model
{
  final String? id;
  final String Title;
  final String artistEmail;
  final String userEmail;
  final String startingTime;
  final String sessionDate;
  final String checkReqStatus;
  final String Status;

  const Session_User_Model(
      {this.id, required this.Title,
    required this.artistEmail,
        required this.userEmail, required this.startingTime,
        required this.sessionDate,
        required this.checkReqStatus,
        required this.Status,
      });

  toJson(){
    return{
      'Title':Title,
      'Starting_Time':startingTime,
      'Session_Date':sessionDate,
      'User_Email':userEmail,
      'Artist_Email':artistEmail,
      'CheckReqStatus':checkReqStatus,
      'Status':Status,

    };}

  factory Session_User_Model.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> documentSnapshot)
  {
    final data=documentSnapshot.data()!;
    return Session_User_Model(
      id: documentSnapshot.id,
      Title: data["Title"], artistEmail:data["Artist_Email"],
    userEmail:data["User_Email"], startingTime:data["Starting_Time"],
    sessionDate:data["Session_Date"], checkReqStatus: data["CheckReqStatus"], Status: data["Status"],);

  }


}

