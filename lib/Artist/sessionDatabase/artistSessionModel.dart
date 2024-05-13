import 'package:cloud_firestore/cloud_firestore.dart';

class ArtistSessionModel
{
  final String? id;
  final String Title;
  final String artistEmail;
  final String startingTime;
  final String sessionDate;
  final String checkReqStatus;
  final String Status;

  const ArtistSessionModel(
      {
        this.id, required this.Title,
        required this.artistEmail,
       required this.startingTime,
        required this.sessionDate,
        required this.checkReqStatus,
        required this.Status,
      });

  toJson(){
    return{
      'Title':Title,
      'Starting_Time':startingTime,
      'Session_Date':sessionDate,
      'Artist_Email':artistEmail,
      'CheckReqStatus':checkReqStatus,
      'Status':Status,

    };}

  factory ArtistSessionModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> documentSnapshot)
  {
    final data=documentSnapshot.data()!;
    return ArtistSessionModel(
      id: documentSnapshot.id,
      Title: data["Title"], artistEmail:data["Artist_Email"],
      startingTime:data["Starting_Time"],
      sessionDate:data["Session_Date"], checkReqStatus: data["CheckReqStatus"], Status: data["Status"],);

  }


}

