import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:takhleekish/User/Navbar/userNavbar.dart';
import 'package:takhleekish/User/cart/cartDatabase/cartModel.dart';

import '../../Artist/artistPersonal/artist_authentication.dart';
import '../cart/cartDatabase/cartController.dart';
import '../cart/cartPages/cartPage.dart';
import '../credentialsFile/user_model.dart';
import '../credentialsFile/user_repository.dart';
import '../payments/paymentPage/paymentPage.dart';

class DetailProductPage extends StatefulWidget {
  final String url;
  final String description;
  final String price;
  final String name;
  final String artistID;
  final String category;
  final String docid;
  final String likeCheck;



  DetailProductPage(this.url, this.price, this.description, this.name,this.category,this.artistID,this.docid,this.likeCheck);

  @override
  _DetailProductPageState createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  bool isFavorited = false;
  final cartController=Get.put(CartController());
  final authrepo = Get.put(Artist_Auth());
  final userRepo = Get.put(User_repo());
  var email;
  @override
  Widget build(BuildContext context) {
    double pageWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: UserNavbar(),
      appBar: AppBar(
        title: const Text("Detail Page",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 30)),
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
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              email=snapshot.data!.email;
              return   SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 880,
                      child:Image.asset("assests/images/dbpic2.jpeg",
                        fit: BoxFit.fitHeight,
                      ),
                      //add background image here
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Hero(
                        tag: "Detail",
                        child: Column(
                          children: [
                            Container(child: Image.network(widget.url)),
                            SizedBox(height: 3,),
                            Divider( // Add a line under the image
                              color: Colors.black, // You can customize the color of the line
                              thickness: 1, // You can adjust the thickness of the line
                              height: 20, // You can adjust the height between the image and the line
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    isFavorited ? Icons.favorite : Icons.favorite_border,
                                    color: isFavorited ? Colors.red : Colors.grey,
                                    size: 30,
                                  ),
                                  onPressed: () async {
                                      if(widget.likeCheck=="false"){
                                        num countLikes=await getLikesCount(widget.name);
                                        if(!isFavorited)
                                        {
                                          countLikes++;
                                          String likesAsString = countLikes.toString();
                                          await FirebaseFirestore.instance.collection("Artifacts").doc(widget.docid)
                                              .update(
                                              {
                                                'likes':likesAsString,
                                              }
                                          );
                                        }
                                        if(isFavorited)
                                        {
                                          countLikes--;
                                          String likesAsString = countLikes.toString();
                                          await FirebaseFirestore.instance.collection("Artifacts").doc(widget.docid)
                                              .update(
                                              {
                                                'likes':likesAsString,
                                              }
                                          );
                                        }
                                        setState(() {
                                          isFavorited = !isFavorited;
                                        });
                                      }


                                  },
                                ),
                                SizedBox(
                                  width: 60,
                                ),
                                Text("Rs: ${widget.price}",
                                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            Divider( // Add a line under the image
                              color: Colors.black, // You can customize the color of the line
                              thickness: 1, // You can adjust the thickness of the line
                              height: 25, // You can adjust the height between the image and the line
                            ),
                            SizedBox(height: 3,),
                            Row(
                              children: [
                                Text("Name:  ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                                Text("${widget.name}",
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Divider( // Add a line under the image
                              color: Colors.black, // You can customize the color of the line
                              thickness: 1, // You can adjust the thickness of the line
                              height: 25, // You can adjust the height between the image and the line
                            ),
                            SizedBox(height: 5,),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text("About:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                            ),
                            SizedBox(height: 5,),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text("${widget.description}",
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                            ),
                            SizedBox(height: 60,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [

                                Container(
                                  height: 50,
                                  width: 170,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      await FirebaseFirestore.instance.collection("Artifacts").doc(widget.docid)
                                          .update(
                                          {
                                            'saleCheck':"true",
                                            'cartCheck':"true",
                                          }
                                      );
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentPage(widget.price,email)));

                                    },
                                    child: Text("Purchase now",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15.0)
                                        )
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 170,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      bool repCheck = await isRepeat(widget.name);
                                      if(repCheck)
                                        {
                                          Get.snackbar("Sorry", "Artifact is already added in cart.",
                                              snackPosition:SnackPosition.BOTTOM,
                                              backgroundColor: Colors.pink.withOpacity(0.5),
                                              colorText: Colors.black);
                                        }
                                      else{
                                        final cart=Cart_model(name: widget.name,
                                            ArtistId: email,
                                            price: widget.price,
                                            category: widget.category,
                                            description: widget.description,
                                            url: widget.url, productDocId: widget.docid);
                                        cartController.createCart(cart);
                                      }
                                      print(widget.docid);


                                      await FirebaseFirestore.instance.collection("Artifacts").doc(widget.docid)
                                          .update(
                                          {
                                            'saleCheck':"true",
                                            'cartCheck':"true",

                                          }
                                      );


                                    },
                                    
                                    child: Text("Add to cart",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.yellow,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15.0)
                                        )
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
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
      )

    );
  }
  Future<User_model?> getData() async {
    final email = authrepo.firebaseUser.value?.email;
    if (email != null) {
      return await userRepo.getUserDetail(email);
    }
    return null; // Handle the case where email is null
  }
  Future<bool> isRepeat(String? name) async {
    if (name == null) {
      return false;
    }
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Cart')
          .where('Name', isEqualTo: name)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking if user is an artist: $e');
      return false;
    }
  }

  Future<num> getLikesCount(String? name) async {
    if (name == null) {
      return 0; // Return 0 if name is null
    }
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Artifacts')
          .where('Name', isEqualTo: name)
          .get();

      num totalLikes = 0;
      for (var doc in querySnapshot.docs) {
        // Assuming 'Likes' is the field storing likes count in the database
        var likes = doc['likes'];
        totalLikes += num.tryParse(likes) ?? 0; // Adding likes count to totalLikes
      }
      return totalLikes;
    } catch (e) {
      print('Error retrieving likes count: $e');
      return 0; // Return 0 in case of error
    }
  }
}