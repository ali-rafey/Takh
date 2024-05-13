import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:takhleekish/User/payments/paymentPage/paymentPage.dart';

class AuctionProductPayment extends StatefulWidget
{
  final String url;
  final String name;
  final String price;
  final String docid;
  final String email;
  AuctionProductPayment
      (
      this.price,
      this.name,
      this.url,
      this.docid,
      this.email,
      );
  @override
  State<AuctionProductPayment> createState() => _AuctionProductPaymentState();
}

class _AuctionProductPaymentState extends State<AuctionProductPayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:[
        Container(
        width: double.infinity,
        height: 880,
        child:Image.asset("assests/images/dbpic2.jpeg",
          fit: BoxFit.fitHeight,
        ),
        //add background image here
      ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
            children: [
              SizedBox(
                height: 40,
              ),

              Container(child: Image.network(widget.url)),
              SizedBox(height: 3,),
              Divider( // Add a line under the image
                color: Colors.black, // You can customize the color of the line
                thickness: 1, // You can adjust the thickness of the line
                height: 20, // You can adjust the height between the image and the line
              ),
              SizedBox(
                width: 60,
              ),
              Text("Name: ${widget.name}",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              Divider( // Add a line under the image
                color: Colors.black, // You can customize the color of the line
                thickness: 1, // You can adjust the thickness of the line
                height: 20, // You can adjust the height between the image and the line
              ),
              SizedBox(
                width: 60,
              ),
              Text("Bill: ${widget.price}",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              Divider( // Add a line under the image
                color: Colors.black, // You can customize the color of the line
                thickness: 1, // You can adjust the thickness of the line
                height: 20, // You can adjust the height between the image and the line
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                height: 60,
                width: 200,
                child: ElevatedButton(
                  onPressed: () async {

                    await FirebaseFirestore.instance.collection("Auction").doc(widget.docid)
                        .update(
                        {
                          'paid':"true",

                        }
                    );
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentPage(widget.price,widget.email)));

                  },
                  child:  Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xffA770EF), Color(0xffCF8BF3), Color(0xffFDB99B)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Payment",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              ),
            ],
                    ),
          ),]

      ),
    );
  }
}