import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:takhleekish/User/cart/cartDatabase/cartModel.dart';
import 'package:takhleekish/User/cart/cartDatabase/cartRepository.dart';

import '../../../User/payments/database/model/model.dart';
import '../../../User/payments/database/repository/Repository.dart';
import '../../adminDashboard/dashboard.dart';

class ApproveOrRejectPayment extends StatefulWidget
{
  final String url;
  final String id;
  final String bill;
  final String user;
  ApproveOrRejectPayment
      (
      this.bill,this.url,this.user,this.id
      );

  @override
  State<ApproveOrRejectPayment> createState() => _ApproveOrRejectPaymentState();
}

class _ApproveOrRejectPaymentState extends State<ApproveOrRejectPayment> {
  @override
  final cartRepo=Get.put(CartRepo());

  Widget build(BuildContext context) {
    double screenHeight=MediaQuery.of(context).size.height;
    return FutureBuilder(
      future: getAllData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            print(snapshot.data!.length);
            return Scaffold(
              body: SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 880,
                      child: Image.asset("assests/images/dbpic2.jpeg"
                        ,fit: BoxFit.fitHeight,),
                      //add background image here
                    ),
                Container(
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight*0.1,),
                      Center(
                        child: Container(
                          width: 300,
                          height: 400,
                          child: Image.network(widget.url),
                        ),
                      ),
                      SizedBox(
                        height:screenHeight*0.04,
                      ),
                      Text("Bill",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      Text("RS ${widget.bill}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
                      SizedBox(
                        height:screenHeight*0.02,
                      ),
                      Text("User Email",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      Text(" ${widget.user}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),

                      SizedBox(
                        height:screenHeight*0.04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 150,
                            height: 40,
                            child: Center(
                              child: ElevatedButton(onPressed:()  async {
                                await FirebaseFirestore.instance.collection("Receipt").doc(widget.id)
                                    .update(
                                    {
                                      'status':"approved",
                                      'Check':"true"
                                    }
                                ).whenComplete(() {
                                  Get.snackbar("Congratulations", "Payment has been approved.",
                                      snackPosition:SnackPosition.BOTTOM,
                                      backgroundColor: Colors.green.withOpacity(0.1),
                                      colorText: Colors.white);

                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminDashboard()));

                                }
                                ).catchError((error,stackTrace){
                                  Get.snackbar("Error", "Something went wrong. Try again",
                                      snackPosition:SnackPosition.BOTTOM,
                                      backgroundColor: Colors.redAccent.withOpacity(0.1),
                                      colorText: Colors.red);
                                  print(error.toString());});

                              }, child:Center(child: Center(child: FaIcon(FontAwesomeIcons.check,color: Colors.white,))),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0)
                                    )
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width:10,),
                          Container(
                            width: 150,
                            height: 40,
                            child: Center(
                              child: ElevatedButton(onPressed:()  async {
                                // var docid=snapshot.data![index].id;
                                await FirebaseFirestore.instance.collection("Receipt").doc(widget.id)
                                    .update(
                                    {
                                      'status':"rejected",
                                      'Check':"true"
                                    }
                                ).whenComplete(() {
                                  Get.snackbar("Congratulations", "Pament has been rejected.",
                                      snackPosition:SnackPosition.BOTTOM,
                                      backgroundColor: Colors.green.withOpacity(0.1),
                                      colorText: Colors.white);
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminDashboard()));

                                }

                                ).catchError((error,stackTrace){
                                  Get.snackbar("Error", "Something went wrong. Try again",
                                      snackPosition:SnackPosition.BOTTOM,
                                      backgroundColor: Colors.redAccent.withOpacity(0.1),
                                      colorText: Colors.red);
                                  print(error.toString());});
                              }, child:Center(child: Center(child: FaIcon(FontAwesomeIcons.x,color: Colors.white,))),

                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0)
                                    )
                                ),
                              ),
                            ),
                          ),],
                      ),

                    ],
                  ),
                )

                  ],
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
  }
  Future<List<Cart_model>> getAllData() async {
    return await cartRepo.getcartDetail(widget.user);
  }
}