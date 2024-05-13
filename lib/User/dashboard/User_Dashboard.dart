import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:takhleekish/Artist/artifacts/artifactModel.dart';
import 'package:takhleekish/Artist/artifacts/artifactRepository.dart';
import 'package:takhleekish/Artist/Navbar/navbar.dart';
import 'package:takhleekish/User/dashboard/detailProductPage.dart';
import 'package:takhleekish/User/Navbar/userNavbar.dart';

import '../cart/cartPages/cartPage.dart';

class User_dashboard extends StatelessWidget {
  final artifactRepo = Get.put(Artifact_repo());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: UserNavbar(),
      backgroundColor:Colors.transparent,
      appBar: AppBar(
        title: const Text("Dashboard", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 30)),
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
        actions: <Widget>[
          IconButton(
            onPressed: () {

              String bill="false";
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CartPage(bill)));
            },
            icon: FaIcon(FontAwesomeIcons.cartShopping, color: Colors.white),
          ),
        ],
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
        child: FutureBuilder<List<Artifact_model>>(
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
                                  if(snapshot.data![i].saleCheck=="false")
                                    Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 12.0,left: 12,right: 12),
                                      child: Container(
                                        width: 150,
                                        child: InkWell(
                                          child: Hero(
                                            tag: "Detail",
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(20),
                                              child: Container(
                                                height: 200,
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
                                                              child: Image.network(snapshot.data![i].url,),
                                                            ),
                                                          ),
                                                          SizedBox(height: 2),
                                                          Text("${snapshot.data![i].name}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500,color: Colors.black)),
                                                          SizedBox(height: 2),
                                                          Text("Rs: ${snapshot.data![i].price}", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600,color: Colors.black)),

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
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailProductPage(snapshot.data![i].url, snapshot.data![i].price,
                                                snapshot.data![i].description, snapshot.data![i].name,
                                                snapshot.data![i].category,snapshot.data![i].ArtistId,
                                                docid, snapshot.data![i].cartCheck)));
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

  Future<List<Artifact_model>> getAllData() async {
    return await artifactRepo.getAllArtifacttDetail();
  }
}
