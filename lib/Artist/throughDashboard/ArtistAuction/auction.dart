import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:takhleekish/Artist/auction/auctionController.dart';
import 'package:takhleekish/Artist/auction/auctionModel.dart';
import 'package:takhleekish/Artist/auction/auctionRepository.dart';
import 'package:takhleekish/Artist/Dashboard/artistDashboard.dart';

class AuctionPage extends StatefulWidget {
  @override
  _AuctionPageState createState() => _AuctionPageState();
}

class _AuctionPageState extends State<AuctionPage> {
  String imageurl = '';
  final formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final controller=Get.put(Auction_Controller());
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
            Padding(
              padding: const EdgeInsets.all(25.0),

                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 70,
                      ),

                         Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                width: 200,
                                height: 40,
                                child:Container(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed:()async{
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
                                              Reference refrenceDirImage=refrenceRoot.child("Auction");
                                              Reference refrenceImageToUpload=refrenceDirImage.child(uniqueName);

                                              try{
                                                SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
                                                await refrenceImageToUpload.putFile(File(file!.path), metadata);
                                                imageurl=await refrenceImageToUpload.getDownloadURL();
                                                Get.snackbar("Congratulations", "Image has been Added for Auction.",
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
                                                Reference refrenceDirImage=refrenceRoot.child('Auction');
                                                Reference refrenceImageToUpload=refrenceDirImage.child(uniqueName);

                                                try{
                                                  SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
                                                  await refrenceImageToUpload.putFile(File(file!.path), metadata);
                                                  imageurl=await refrenceImageToUpload.getDownloadURL();
                                                  Get.snackbar("Congratulations", "Image has been Added for Auction.",
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
                                        ), onClosing: () {  },)
                                      );
                                    },
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
                                          child:
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Icon(Icons.insert_photo,color: Colors.white,),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Text("Upload Image",style: TextStyle(color: Colors.white,fontSize: 18),),
                                            ],
                                          )                                      ),
                                    ),
                                  ),
                                ),

                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),

                      SizedBox(height: 20),

                         Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Container(
                                width: 300,
                                height: 50,
                                child: TextFormField(
                                  controller: controller.Art_bid,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        !RegExp(r'^\d+(\.\d{0,2})?$').hasMatch(value!)) {
                                      return 'Enter correct amount';
                                    }
                                    else {
                                    controller.Art_bid.text=value;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                        borderSide: BorderSide(
                                          width: 2,
                                          color: Color(0xfff77062),
                                        )

                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                        )
                                    ),
                                    prefixIcon: Icon(Icons.currency_exchange),
                                    label:Text("Starting Amount") ,
                                  ),

                                ),
                              ),
                              SizedBox(height: screenHeight * 0.02,),
                              Container(
                                width: 300,
                                height: 50,
                                child: TextFormField(
                                  controller: controller.Art_name,
                                  keyboardType: TextInputType.name,
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        !RegExp(r'([a-zA-Z0-9_\s]+)').hasMatch(value!)) {
                                      return 'Enter correct name';
                                    }
                                    else {
                                      controller.Art_name.text=value;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                        borderSide: BorderSide(
                                          width: 2,
                                          color: Color(0xfff77062),
                                        )

                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                        )
                                    ),
                                    prefixIcon: Icon(Icons.article),
                                    label:Text("Art Name") ,
                                  ),

                                ),
                              ),
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                              Container(
                                width: 300,
                                height: 50,
                                child: TextFormField(
                                  controller: controller.Artist_id,
                                  keyboardType: TextInputType.name,
                                  validator: (value) {
                                    if(value!.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}').hasMatch(value!))
                                    {
                                      return 'Enter correct Email';
                                    }
                                    else {
                                      controller.Artist_id.text = value;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                        borderSide: BorderSide(
                                          width: 2,
                                          color: Color(0xfff77062),
                                        )

                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                        )
                                    ),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.only(left: 12.0,top: 10.0),
                                      child: Container(child: FaIcon(FontAwesomeIcons.idBadge,color: Colors.black,)),
                                    ),
                                    label:Text("Enter Artist Email") ,
                                  ),

                                ),
                              ),
                              SizedBox(height: 10),
                              Text("Auction Date",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                              SizedBox(height: 10,),
                              Column(
                                children: [
                                  Container(
                                    width: 300,
                                    height: 40,
                                    child:Container(
                                      width: double.infinity,
                                      height: 50,
                                      child: ElevatedButton(
                                        onPressed:()async{
                                      final startDate=await pickDate();
                                      if(startDate==null) {
                                      Get.snackbar("Oops", "Auction Date is required",
                                      snackPosition:SnackPosition.BOTTOM,
                                      backgroundColor: Colors.red.withOpacity(0.1),
                                      colorText: Colors.red);
                                      }
                                      setState(() {
                                      controller.auctDate=startDate;
                                      });
                                      },
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
                                              child:
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width:20,
                                                  ),
                                                  Icon(Icons.calendar_month,color: Colors.white,),
                                                  SizedBox(
                                                    width:5,
                                                  ),
                                                  Text("                Date",style: TextStyle(color: Colors.white,fontSize: 20),),
                                                ],
                                              )                                     ),
                                        ),
                                      ),
                                    ),

                                  ),

                                  SizedBox(width: 30,),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  SizedBox(width: 25,),
                                  Text("${controller.auctDate?.day??''}/${controller.auctDate?.month??''}/${controller.auctDate?.year??''}"),
                                  SizedBox(width: 85,),
                                ],
                              ),
                              SizedBox(height: 15),
                              Row(children: [
                                Text("Starting Time",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                                SizedBox(width: 45),
                                Text("Ending Time",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),

                              ],),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Container(
                                    width: 120,
                                    height: 40,
                                    child:Container(
                                      width: double.infinity,
                                      height: 50,
                                      child: ElevatedButton(
                                        onPressed:()async{
                                          final startTime=await pickTime();
                                          if(startTime==null) {
                                            Get.snackbar("Oops", "Starting time is required",
                                                snackPosition:SnackPosition.BOTTOM,
                                                backgroundColor: Colors.red.withOpacity(0.1),
                                                colorText: Colors.red);
                                          }
                                          setState(() {
                                            controller.Art_startingTime=startTime;
                                          });
                                        },
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
                                              child:
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width:8,
                                                  ),
                                                  Icon(Icons.access_time,color: Colors.white,),
                                                  SizedBox(
                                                    width:5,
                                                  ),
                                                  Text("Time",style: TextStyle(color: Colors.white,fontSize: 20),),
                                                ],
                                              )                                    ),
                                        ),
                                      ),
                                    ),

                                  ),


                                  SizedBox(width:12,),
                                  Row(
                                    children: [
                                      SizedBox(width: 30,),

                                      Container(
                                        width: 120,
                                        height: 40,
                                        child:Container(
                                          width: double.infinity,
                                          height: 50,
                                          child: ElevatedButton(
                                            onPressed:()async{
                                              final endTime=await pickTime();
                                              if(endTime==null) {
                                                Get.snackbar("Oops", "Ending time is required",
                                                    snackPosition:SnackPosition.BOTTOM,
                                                    backgroundColor: Colors.red.withOpacity(0.1),
                                                    colorText: Colors.red);
                                              }
                                              setState(() {
                                                controller.Art_endingTime=endTime;
                                              });
                                            },
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
                                                  child:
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width:8,
                                                      ),
                                                      Icon(Icons.access_time,color: Colors.white,),
                                                      SizedBox(
                                                        width:5,
                                                      ),
                                                      Text("Time",style: TextStyle(color: Colors.white,fontSize: 20),),
                                                    ],
                                                  )                                    ),
                                            ),
                                          ),
                                        ),

                                      ),


                                    ],
                                  ),
                                ],
                              ),
                              Row(children: [
                                SizedBox(width:5),
                                Text("${controller.Art_startingTime?.hourOfPeriod??''}:${controller.Art_startingTime?.minute??''} ${controller.Art_startingTime?.period == DayPeriod.am ? 'AM' : 'PM'}"),
                                SizedBox(width:140),
                                Text("${controller.Art_endingTime?.hourOfPeriod??''}:${controller.Art_endingTime?.minute??''} ${controller.Art_endingTime?.period == DayPeriod.am ? 'AM' : 'PM'}"),
                              ],)

                            ],
                          ),
                        ),

                      SizedBox(height: 20),
                      Container(
                        width: 300,
                        height: 40,
                        child:Container(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed:(){
                              if (formkey.currentState!.validate()){
                                print('${controller.Art_name}');




                                // Convert starting and ending time to TimeOfDay objects
                                TimeOfDay startingTime = controller.Art_startingTime!;
                                TimeOfDay endingTime = controller.Art_endingTime!;
                                if(startingTime!=null && endingTime!=null)
                                {
                                  // Convert starting and ending time to DateTime objects for comparison
                                  DateTime startingDateTime = DateTime(1, 1, 1, startingTime.hour, startingTime.minute);
                                  DateTime endingDateTime = DateTime(1, 1, 1, endingTime.hour, endingTime.minute);
                                  // Compare starting and ending times
                                  if (startingDateTime.isBefore(endingDateTime)) {
                                    // Starting time is before ending time
                                    print('Starting time is before ending time');
                                    final auction = Auction_model(
                                        artName: controller.Art_name.text.trim(),
                                        ArtistId: controller.Artist_id.text.trim(),
                                        bid: controller.Art_bid.text.trim(),
                                        startingTime: controller.Art_startingTime
                                            .toString().trim(),
                                        endingTime: controller.Art_endingTime
                                            .toString().trim(),
                                        auctionDate: controller.auctDate
                                            .toString().trim(),
                                        url: imageurl,
                                        status: "none", checkAuc: "false", checkBidStatus: 'false', isLive: 'false', liveBaseBid: 'false', buyer: '', paid: 'false');
                                    Auction_Controller.instance.createAuction(
                                        auction);
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => ArtistDashboard()),);
                                    controller.Artist_id.clear();
                                    controller.Art_bid.clear();
                                    controller.Art_name.clear();
                                    controller.auctDate = null;
                                    controller.Art_startingTime = null;
                                    controller.Art_endingTime = null;
                                    imageurl = '';
                                  }
                                  else{
                                    Get.snackbar("OOpS", "Starting time must comes before ending time",
                                        snackPosition:SnackPosition.BOTTOM,
                                        backgroundColor: Colors.red.withOpacity(0.1),
                                        colorText: Colors.red);
                                  }
                                }else {
                                  // Handle the case where startingTime or endingTime is null
                                  print('Starting time or ending time is null');
                                  // You can show a message or take appropriate action here
                                }



                              }
                              else{
                                Get.snackbar("OOpS", "Auction request has not been send",
                                    snackPosition:SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red.withOpacity(0.1),
                                    colorText: Colors.red);
                              }

                            },
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
                                  child:
                                  Text('Submit Auction',style: TextStyle(color: Colors.white,fontSize: 20)),
                              ),
                            ),
                          ),
                        ),

                      ),



                    ],
                  ),
                ),

            ),
          ],
        ),
      )
    );
  }
  Future pickImageFromGallery()async{
    final returnImage= await ImagePicker().pickImage(source: ImageSource.gallery);
  }
  Future<DateTime?> pickDate()=>showDatePicker(context: context, firstDate: DateTime.now(),initialDate: DateTime.now(), lastDate: DateTime(2100));
 Future<TimeOfDay?> pickTime()=>showTimePicker(context: context, initialTime: TimeOfDay.now());
}

void main() {
  runApp(MaterialApp(
    home: AuctionPage(),
  ));
}
