
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:takhleekish/Artist/throughNavbar/AnalyticsPage/barGraph/BarGraph.dart';

import '../../artifacts/artifactModel.dart';
import '../../artifacts/artifactRepository.dart';
import '../../artistPersonal/artist_authentication.dart';
import '../../artistPersonal/artist_model.dart';
import '../../artistPersonal/artist_repository.dart';





class ArtistAnalyticsPage extends StatefulWidget {
  @override
  State<ArtistAnalyticsPage> createState() => _ArtistAnalyticsPageState();
}

class _ArtistAnalyticsPageState extends State<ArtistAnalyticsPage> {
  @override

  void initState() {
    super.initState();
  }
  final authrepo = Get.put(Artist_Auth());

  final artistRepo = Get.put(Artist_repo());

  final artifactRepo = Get.put(Artifact_repo());

  var dp;

  var email;


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                Artist_model artistModel = snapshot.data!;
                dp = snapshot.data!.url;
                email=snapshot.data!.email;
                return FutureBuilder(
                  future: getAllData(email),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        double abstractCount=0;
                        double landscapeCount=0;
                        double portraitCount=0;
                        double StillLifeCount=0;
                        double ModernArtCount=0;
                        double ContemporaryCount=0;
                        var saleAmount=0;
                        var productCount=0;
                        var likeCount=0;
                        productCount=snapshot.data!.length;

                        for(int i=0;i< productCount;i++)
                          {
                            if(snapshot.data![i].category=="Abstract" && snapshot.data![i].saleCheck=="true" )
                              abstractCount++;
                            if(snapshot.data![i].category=="Landscape"&& snapshot.data![i].saleCheck=="true")
                              landscapeCount++;
                            if(snapshot.data![i].category=="Portrait"&& snapshot.data![i].saleCheck=="true")
                              portraitCount++;
                            if(snapshot.data![i].category=="Still Life"&& snapshot.data![i].saleCheck=="true")
                              StillLifeCount++;
                            if(snapshot.data![i].category=="Modern Art"&& snapshot.data![i].saleCheck=="true")
                              ModernArtCount++;
                            if(snapshot.data![i].category=="Contemporary"&& snapshot.data![i].saleCheck=="true")
                              ContemporaryCount++;
                            if(snapshot.data![i].saleCheck=="true")
                              {
                                var num=int.parse(snapshot.data![i].price);
                                saleAmount+=num;
                              }
                            if(snapshot.data![i].likes!="0")
                            {

                              var likes=int.parse(snapshot.data![i].likes);
                              likeCount+=likes;

                            }
                          }

                        print(ModernArtCount);
                        return Scaffold(
                          body: SingleChildScrollView(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xffF0A2C9),
                                    Color(0xffD2A5D0),
                                    Color(0xff6F9BB4),
                                  ],
                                ),
                              ),
                              child:Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(height: 16),
                                Center(
                            
                                  child: Container(
                                    width: 200,
                                    height: 200,
                                    child: CircleAvatar(
                                      child: ClipOval(
                            
                                        child: Image.network(dp),
                                      ),
                                    ),
                            
                            
                                  ),
                                ),
                                SizedBox(height: 30),

                                Text("Stats :",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                SizedBox(height: 20),
                                Card(
                                  elevation: 6,
                                  color: Color(0xffcbb4d4),
                                  child: Container(
                                    width: 200,
                                    height: 200,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 25),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("Listed Products :",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                                            ),
                                            SizedBox(width: 165),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 8.0,right: 8.0),
                                              child: Text("$productCount",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("Total Sales :",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                                            ),
                                            SizedBox(width: 160),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 8.0,right: 6.0),
                                              child: Text("RS $saleAmount",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("Total Likes :",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                                            ),
                                            SizedBox(width: 205),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 8.0,),
                                              child: Text("$likeCount",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30),
                                Text("Sales per Category :",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                SizedBox(height: 30),
                                Container(
                                  height: 250,
                                  child: BarGraph(AbstractAmount: abstractCount, landscapeAmount: landscapeCount,
                                    portraitAmount: portraitCount, StillLifeAmount: StillLifeCount,
                                    ModernArtAmount: ModernArtCount, ContemporaryAmount: ContemporaryCount,
                                  ),
                            
                                )
                            
                              ],
                            ),
                                                    ),
                            
                            ),
                          ),
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
        )

    );
  }

  Future<Artist_model?> getData() async {
    final email = authrepo.firebaseUser.value?.email;
    if (email != null) {
      return await artistRepo.getArtistDetail(email);
    }
    return null; // Handle the case where email is null
  }

  Future<List<Artifact_model>> getAllData(String email) async {
    return await artifactRepo.getSpecificArtistArtifacttDetail(email);
  }
}


