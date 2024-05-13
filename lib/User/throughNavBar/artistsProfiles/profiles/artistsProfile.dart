import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:takhleekish/Artist/artistPersonal/artist_model.dart';
import 'package:takhleekish/Artist/artistPersonal/artist_repository.dart';
import 'package:takhleekish/User/throughNavBar/artistsProfiles/artistArtifacts/ArtistArtifacts.dart';

import '../../../../Artist/artifacts/artifactRepository.dart';
import '../../../Navbar/userNavbar.dart';
import '../../../cart/cartPages/cartPage.dart';

class ArtistsProfiles extends StatelessWidget{
  final artistRepo = Get.put(Artist_repo());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: UserNavbar(),
      backgroundColor:Colors.transparent,
      appBar: AppBar(
        title: const Text("Artists", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 30)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
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
        ),

      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
        child: FutureBuilder(
          future: getAllData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: (snapshot.data!.length / 2).ceil(), // Calculate the number of rows
                    itemBuilder: (context, rowIndex) {
                      return Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              for (int i = rowIndex * 2; i < (rowIndex * 2) + 2; i++)
                                if (i < snapshot.data!.length)
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 12.0,left: 12,right: 12),
                                        child: Container(
                                          width: 160,
                                          child: InkWell(
                                            child: Hero(
                                              tag: "Detail",
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(20),
                                                child: Container(
                                                  height: 220,

                                                  color: Colors.transparent,
                                                  child: Stack(
                                                    children: [
                                                      BackdropFilter(
                                                        filter:ImageFilter.blur(
                                                            sigmaX: 4.0,
                                                            sigmaY: 4.0
                                                        ),
                                                        child: Container(),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(10),
                                                            border: Border.all(color:Colors.white.withOpacity(0.13) ),
                                                            gradient: LinearGradient(
                                                              begin: Alignment.topLeft,
                                                              end: Alignment.bottomRight,
                                                              colors: [
                                                                Colors.white.withOpacity(0.65),
                                                                Colors.white.withOpacity(0.10)
                                                              ],)
                                                        ),
                                                      ),
                                                      Center(
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              height: 130,
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(top: 8.0),
                                                                child: ClipOval(child: Image.network(snapshot.data![i].url,)),
                                                              ),
                                                            ),
                                                            SizedBox(height: 2),
                                                            Text("${snapshot.data![i].name}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500,color: Colors.black)),
                                                            SizedBox(height: 2),
                                                            Text("${snapshot.data![i].email}", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600,color: Colors.black)),

                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            onTap: (){
                                              var docid=snapshot.data![i].id?? "No id";
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ArtistsArtifacts(snapshot.data![i].email)));
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      );

                    },
                  ),
                );
              } else if (snapshot.hasError) {
                print({snapshot.hasError});
                return Text('Data not found');
              } else {
                return Text('Something went wrong');
              }

            } else {
              // Return Center widget to display CircularProgressIndicator in the center
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),

    );
  }
  Future<List<Artist_model>> getAllData() async {
    return await artistRepo.getAllArtistDetail();
  }
}