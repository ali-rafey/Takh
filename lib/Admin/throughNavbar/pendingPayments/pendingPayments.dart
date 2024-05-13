import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:takhleekish/Admin/adminDashboard/dashboard.dart';
import 'package:takhleekish/Admin/navbar/adminNavbar.dart';
import 'package:takhleekish/Artist/artifacts/artifactModel.dart';
import 'package:takhleekish/Artist/artifacts/artifactRepository.dart';

class PendingPayments extends StatelessWidget
{
  final artifactRepo=Get.put(Artifact_repo());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getAllData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Scaffold(
                  body:Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 880,
                        child: Image.asset("assests/images/dbpic2.jpeg"
                          ,fit: BoxFit.fitHeight,),
                        //add background image here
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.separated(
                                itemCount: snapshot.data!.length, // Number of auction (fetch from the database)
                                itemBuilder: (context, index) {

                                  if(snapshot.data![index].cartCheck=="true")
                                  {
                                    print(index);
                                    return Slidable(
                                      actionPane: SlidableDrawerActionPane(),
                                      actionExtentRatio: 0.25,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(15.0)
                                        ),
                                        child: ListTile(
                                          leading: ClipOval(child:Image.network(snapshot.data![index].url)),
                                          title: Text('Name: ${snapshot.data![index].name} '),
                                          subtitle: Text("Price:  ${snapshot.data![index].price}"),
                                          trailing: Text("Paid") ,
                                          onTap: () async {
                                            var docid=snapshot.data![index].id;
                                            await FirebaseFirestore.instance.collection("Artifacts").doc(docid)
                                                .update(
                                                {
                                                  'cartCheck':"false"
                                                }
                                            );
                                            Navigator.push(context,MaterialPageRoute(builder: (context)=>AdminDashboard()));
                                          },
                                        ),
                                      ),
                                    );
                                  }
                                  else
                                  {
                                    return Container();
                                  }


                                }, separatorBuilder: (BuildContext context, int index) { return const Divider(); },
                              ),
                            ),

                          ],
                        ),
                      ) ,
                    ],
                  )
              );
            } else if (snapshot.hasError) {
              return Text('User not found');
            } else {
              return Text('Something went wrong');
            }
          }
          else {
            // Return Center widget to display CircularProgressIndicator in the center
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
  Future<List<Artifact_model>> getAllData() async {
    return await artifactRepo.getAllArtifacttDetail();
  }
}