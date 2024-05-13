import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:takhleekish/User/dashboard/User_Dashboard.dart';
import 'package:takhleekish/User/payments/database/controller/controller.dart';
import 'package:takhleekish/User/payments/database/model/model.dart';

class PaymentPage extends StatefulWidget
{
  final String amount;
  final String email;
  PaymentPage(
      this.amount, this.email
      );

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String imageurl='';
  late String url;
  @override
  Widget build(BuildContext context) {

    double screenHeight=MediaQuery.of(context).size.height;
    double screenWidth=MediaQuery.of(context).size.width;
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
            Center(
              child: Container(
                child: Column(
                  children: [
                    SizedBox(height: screenHeight*0.01,),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0.0),
                      child: Container(
                          width: 280,
                          height: 280,
                          child: Image.asset("assests/images/homeScreenPic.png")),
                    ),
                    SizedBox(
                      height:screenHeight*0.04,
                    ),
                    Text("Account Title",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Text("Syed Ghazi Hussain",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
                    SizedBox(
                      height:screenHeight*0.02,
                    ),
                    Text("Account Number",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Text("22167901717903",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),

                    SizedBox(
                      height:screenHeight*0.02,
                    ),
                    Text("Bank",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Text("HBL",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
                    SizedBox(
                      height:screenHeight*0.02,
                    ),
                    Text("Total Amount",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Text("${widget.amount}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),

                    SizedBox(
                      height:screenHeight*0.02,
                    ),

                      Container(
                        width: screenWidth*0.4,
                        height: screenHeight*0.05,
                        child:Container(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed:()  async{
                              await showModalBottomSheet(context: context, builder: (context)=>BottomSheet(
                                builder: (context)=>Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(leading:Icon(Icons.camera),title: Text("Camera"),onTap: () async{
                                      ImagePicker imagePicker=ImagePicker();
                                      XFile? file=await imagePicker.pickImage(source: ImageSource.camera);
                                      print('${file?.path}');
                                      if(file==null) return null;
                                      String uniqueName=DateTime.now().millisecondsSinceEpoch.toString();
                                      Reference refrenceRoot=FirebaseStorage.instance.ref();
                                      Reference refrenceDirImage=refrenceRoot.child("Receipts");
                                      Reference refrenceImageToUpload=refrenceDirImage.child(uniqueName);

                                      try{
                                        SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
                                        await refrenceImageToUpload.putFile(File(file!.path), metadata);
                                        imageurl=await refrenceImageToUpload.getDownloadURL();
                                        print(imageurl);
                                        url=imageurl;
                                        Get.snackbar("Congratulations", "Image has been Added.",
                                            snackPosition:SnackPosition.BOTTOM,
                                            backgroundColor: Colors.green.withOpacity(0.1),
                                            colorText: Colors.green);


                                      }catch(error)
                                      {
                                        Get.snackbar("Sorry", "Please try again.",
                                            snackPosition:SnackPosition.BOTTOM,
                                            backgroundColor: Colors.red.withOpacity(0.1),
                                            colorText: Colors.red);
                                      }







                                    },),
                                    ListTile(leading:Icon(Icons.insert_photo),title: Text("Gallery"),onTap: () async {
                                      {
                                        ImagePicker imagePicker=ImagePicker();
                                        XFile? file=await imagePicker.pickImage(source: ImageSource.gallery);
                                        if(file==null) return null;
                                        String uniqueName=DateTime.now().microsecondsSinceEpoch.toString();
                                        Reference refrenceRoot=FirebaseStorage.instance.ref();
                                        Reference refrenceDirImage=refrenceRoot.child('Receipts');
                                        Reference refrenceImageToUpload=refrenceDirImage.child(uniqueName);

                                        try{
                                          SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
                                          await refrenceImageToUpload.putFile(File(file!.path), metadata);
                                          imageurl=await refrenceImageToUpload.getDownloadURL();
                                          url=imageurl;
                                          Get.snackbar("Congratulations", "Image has been Added.",
                                              snackPosition:SnackPosition.BOTTOM,
                                              backgroundColor: Colors.green.withOpacity(0.1),
                                              colorText: Colors.green);



                                        }catch(error)
                                        {
                                          Get.snackbar("Sorry", "Please try again.",
                                              snackPosition:SnackPosition.BOTTOM,
                                              backgroundColor: Colors.red.withOpacity(0.1),
                                              colorText: Colors.red);
                                        }

                                      }

                                    },)

                                  ],
                                ), onClosing: () {

                              },)

                              );
                            } ,
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                            child: Ink(
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
                                  "Upload Receipt",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                      ),
                    SizedBox(
                      height:screenHeight*0.04,
                    ),

                    Container(
                      width: screenWidth*0.8,
                      height: screenHeight*0.06,
                      child:Container(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed:() {
                            print(url);
                            final payment=Payment_model(
                                bill: widget.amount,
                                reciept: imageurl,
                                status: "pending", paymentCheck: 'false', UserId: widget.email);
                            Get.put(Payment_Controller()).createReceipt(payment);
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>User_dashboard()));

                          } ,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          child: Ink(
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
                                "Submit",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                    ),




                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}