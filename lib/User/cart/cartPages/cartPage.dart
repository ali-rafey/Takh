import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:takhleekish/User/cart/cartDatabase/cartModel.dart';
import 'package:takhleekish/User/cart/cartDatabase/cartRepository.dart';
import 'package:takhleekish/User/payments/paymentPage/paymentPage.dart';
import '../../../Artist/artistPersonal/artist_authentication.dart';
import '../../../Artist/auction/auctionModel.dart';
import '../../../Artist/controllers/artist_controller.dart';
import '../../credentialsFile/user_model.dart';
import '../../credentialsFile/user_repository.dart';

class CartPage extends StatefulWidget
{
   String billCheck;
  CartPage(this.billCheck);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var email;
  num bill=0;



  final cartRepo=Get.put(CartRepo());
  final authrepo = Get.put(Artist_Auth());
  final userRepo = Get.put(User_repo());
  bool check=false;
  bool isBillCalculated = false;

  void initState() {
    super.initState();
    _fetchDataAndCalculateBill();
  }

  void _fetchDataAndCalculateBill() async {
    final userData = await getData();
    if (userData != null) {
      email = userData.email;
      final cartData = await getAllData(email);
      if (!isBillCalculated) {
        num calculatedBill = _calculateBill(cartData);
        setState(() {
          bill = calculatedBill;
          isBillCalculated = true;
        });
      }
    }
  }

  num _calculateBill(List<Cart_model> cartData) {
    num totalPrice = 0;
    for (var item in cartData) {
      totalPrice += num.parse(item.price);
    }
    return totalPrice;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade200,
      appBar: AppBar(
        title: Row(
            children:[
              Center(
                child: const Text(
                  "Cart",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(Icons.shopping_cart,color: Colors.white,)

            ]

        ),
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
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                email=snapshot.data!.email;
                return  FutureBuilder(
                  future: getAllData(email),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        print(isBillCalculated);
                        print(isBillCalculated);
                        if (!isBillCalculated) {
                          _fetchDataAndCalculateBill();//
                          // Call _calculateBill only once
                         refreshBill();
                        }

                        return Scaffold(
                          body: Container(
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
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ListView.separated(
                                      itemCount: snapshot.data!.length, // Number of auction (fetch from the database)
                                      itemBuilder: (context, index) {
                                        print(bill);
                                        return Slidable(
                                          actionPane: SlidableDrawerActionPane(),
                                          actionExtentRatio: 0.25,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(15.0),
                                            ),
                                            child: ListTile(
                                              leading: ClipOval(child: Image.network(snapshot.data![index].url)),
                                              title: Text('Cost:  ${snapshot.data![index].price}'),
                                              subtitle: Text('Name:  ${snapshot.data![index].name}'),
                                              trailing: IconButton(
                                                onPressed: () async {
                                                  String docid=snapshot.data![index].id?? "No id";
                                                  num artifactPrice = num.parse(snapshot.data![index].price);
                                                  // Subtract the artifact price from the total bill
                                                  print(bill);
                                                  setState(() {
                                                    bill -= artifactPrice;
                                                  });
                                                  await FirebaseFirestore.instance.collection("Artifacts").doc(snapshot.data![index].productDocId)
                                                      .update(
                                                      {
                                                        'saleCheck':"false",
                                                      }
                                                  );
                                                  await FirebaseFirestore.instance.collection("Cart").doc(docid)
                                                      .delete().whenComplete(() {
                                                    Get.snackbar("Successfully", "Artifact hass been removed",
                                                        snackPosition:SnackPosition.BOTTOM,
                                                        backgroundColor: Colors.pink.withOpacity(0.5),
                                                        colorText: Colors.black);
                                                  }
                                                  ).catchError((error,stackTrace){
                                                    Get.snackbar("Error", "Something went wrong. Try again",
                                                        snackPosition:SnackPosition.BOTTOM,
                                                        backgroundColor: Colors.redAccent.withOpacity(0.1),
                                                        colorText: Colors.red);
                                                    print(error.toString());});
                                                  // if(docid==widget.artifactId)
                                                  // await FirebaseFirestore.instance.collection("Artifacts").doc(widget.artifactId)
                                                  //     .update(
                                                  //     {
                                                  //       'cartCheck':"false",
                                                  //
                                                  //
                                                  //     }
                                                  // );

                                                },
                                                icon: Icon(Icons.delete),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (BuildContext context, int index) => const Divider(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text('User not found');
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
      ),

      bottomNavigationBar: Container(
        width: double.infinity, // Match the width of the screen
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),

            topRight: Radius.circular(40.0),
          ),
        ),

        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12.0,left: 29),
              child: Row(children:[
                Text("Subtotal                                     ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                Text("RS ${bill}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
          ])),
            Padding(
                padding: const EdgeInsets.only(top: 5.0,left: 29),
                child: Row(children:[
                  Text("Discount                                    ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                  Text("RS 0",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                ])),
            Padding(
                padding: const EdgeInsets.only(top: 5.0,left: 29),
                child: Row(children:[
                  Text("Total                                           ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                  Text("RS ${bill}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                ])),

            ElevatedButton(
              onPressed: () {
                String amount = bill.toString();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentPage(amount,email)));

              },
              child: Text('Checkout',style: TextStyle(color: Colors.white,fontSize: 20)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffF0A2C9),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                ),),
            ),
          ],
        ),

      ),
    );

  }

  @override
  void refreshBill() {

    setState(() {
      isBillCalculated = true; // Reset the flag to trigger recalculation
    });
  }



  Future<User_model?> getData() async {
    final email = authrepo.firebaseUser.value?.email;
    if (email != null) {
      return await userRepo.getUserDetail(email);
    }
    return null; // Handle the case where email is null
  }
  Future<List<Cart_model>> getAllData(String email) async {
    return await cartRepo.getcartDetail(email);
  }
}