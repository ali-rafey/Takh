import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:takhleekish/Artist/artistPersonal/art_login.dart';
import 'package:takhleekish/Artist/controllers/artist_controller.dart';
import 'package:takhleekish/Artist/artistPersonal/artist_model.dart';

class Art_Signup extends StatelessWidget{
  String imageurl='';
  @override
  final formkey=GlobalKey<FormState>();
  TextEditingController Otp=TextEditingController();
  EmailOTP myAuth = EmailOTP();
  Widget build(BuildContext context) {
    final controller=Get.put(Artist_Controller());
    double screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: [
          Container(
            width: double.infinity,
            height: 880,
            child: Image.asset("assests/images/dbpic2.jpeg"
              ,fit: BoxFit.fitHeight,),
            //add background image here
          ),
          Center(
            child: Container(
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    SizedBox(
                      height:screenHeight*0.15,
                    ),
                    Text("Takhleeqish",style: TextStyle(fontSize: 55,fontFamily:'main',fontWeight: FontWeight.w600),),
                    SizedBox(
                      height:screenHeight*0.15,
                    ),
                    Container(
                      width: 345,
                      height: 50,
                      child: TextFormField(
                        controller: controller.Arname,
                        keyboardType: TextInputType.name,
                        validator:(value){
                          if(value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value!))
                          {
                            return 'Enter correct name';
                          }
                          else{
                            controller.Arname.text=value;
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
                            padding: const EdgeInsets.only(left: 12.0,top: 7.0),
                            child: Container(child: FaIcon(FontAwesomeIcons.user,color: Colors.black,)),
                          ),
                          labelText: "Enter Full Name",
                        ),

                      ),
                    ),
                    SizedBox(
                      height:screenHeight*0.02,
                    ),
                    Container(
                      width: 345,
                      height: 50,
                      child: TextFormField(
                        controller: controller.Aremail,
                        keyboardType: TextInputType.emailAddress,
                        validator:(value){
                          if(value!.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}').hasMatch(value!))
                          {
                            return 'Enter correct Email';
                          }
                          else{
                            controller.Aremail.text=value;
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
                            prefixIcon: Icon(Icons.mail,color: Colors.black,),
                            labelText: "Enter Email",
                            suffixIcon: TextButton(
                              child: Text("Send OTP",style: TextStyle(fontSize: 12),),
                              onPressed: () async {
                                myAuth.setConfig(
                                    appEmail: "Takhleeqish@gmail.com",
                                    appName: "Email OTP",
                                    userEmail: controller.Aremail.text,
                                    otpLength: 4,
                                    otpType: OTPType.digitsOnly
                                );
                                if (await myAuth.sendOTP() == true) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content:Text("OTP send Successfully"), ));
                                }
                                else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content:Text("OTP Not send"), ));

                                }
                              },
                            )
                        ),

                      ),
                    ),
                    SizedBox(
                      height:screenHeight*0.02,
                    ),
                    Container(
                      width: 345,
                      height: 50,
                      child: TextFormField(
                        controller: Otp,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'OTP is Required';
                          } else {
                            Otp.text = value;
                          }
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                width: 2,
                                color: Color(0xfff77062),
                              )),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                color: Colors.blue,
                              )),
                          prefixIcon: Icon(
                            Icons.numbers_outlined,
                            color: Colors.black,
                          ),
                          label: Text("OTP"),
                          hintText: "Enter OTP",
                        ),
                      ),
                    ),
                    SizedBox(
                      height:screenHeight*0.02,
                    ),
                    Container(
                      width: 345,
                      height: 50,
                      child: TextFormField(
                        controller: controller.Arcnic,
                        validator:(value){
                          if(value!.isEmpty || !RegExp(r'^([0-9]{5})[\-]([0-9]{7})[\-]([0-9]{1})$').hasMatch(value!))
                          {
                            return 'CNIC No must follow the XXXXX-XXXXXXX-X format!';
                          }
                          else{

                            controller.Arcnic.text=value;
                          }
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              width: 2,
                              color: Color(0xfff77062),
                            ),

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
                          labelText: "Enter CNIC",

                        ),
                      ),
                    ),
                    SizedBox(
                      height:screenHeight*0.02,
                    ),
                    Container(
                      width: 345,
                      height: 50,
                      child: TextFormField(
                        controller: controller.Arpass,
                        validator:(value){
                          if(value!.isEmpty || !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value!))
                          {
                            return '8 digits,one (upper,lower case,digit,Special character)';
                          }
                          else{
                            controller.Arpass.text=value;
                          }
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              width: 2,
                              color: Color(0xfff77062),
                            ),

                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                color: Colors.blue,
                              )
                          ),
                          prefixIcon: Icon(Icons.lock,color: Colors.black,),
                          labelText: "Enter Password",

                        ),
                      ),
                    ),
                    SizedBox(
                      height:screenHeight*0.02,
                    ),

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
                                    if(file==null) return null;
                                    String uniqueName=DateTime.now().microsecondsSinceEpoch.toString();
                                    Reference refrenceRoot=FirebaseStorage.instance.ref();
                                    Reference refrenceDirImage=refrenceRoot.child("ArtitsImages");
                                    Reference refrenceImageToUpload=refrenceDirImage.child(uniqueName);

                                    try{SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
                                    await refrenceImageToUpload.putFile(File(file!.path), metadata);
                                    controller.Artist_url =await refrenceImageToUpload.getDownloadURL();
                                    Get.snackbar("Congratulations", "Image has been added",
                                        snackPosition:SnackPosition.BOTTOM,
                                        backgroundColor: Colors.green.withOpacity(0.1),
                                        colorText: Colors.green);


                                    }catch(error)
                                    {

                                    }






                                  },),
                                  ListTile(leading:Icon(Icons.insert_photo),title: Text("Gallery"),onTap: () async {
                                    {
                                      ImagePicker imagePicker=ImagePicker();
                                      XFile? file=await imagePicker.pickImage(source: ImageSource.gallery);
                                      if(file==null) return null;
                                      String uniqueName=DateTime.now().microsecondsSinceEpoch.toString();
                                      Reference refrenceRoot=FirebaseStorage.instance.ref();
                                      Reference refrenceDirImage=refrenceRoot.child("ArtistImage");
                                      Reference refrenceImageToUpload=refrenceDirImage.child(uniqueName);

                                      try{
                                        SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
                                        await refrenceImageToUpload.putFile(File(file!.path), metadata);
                                        controller.Artist_url =await refrenceImageToUpload.getDownloadURL();
                                        print('${controller.Artist_url}');
                                        Navigator.pop(context);
                                        Get.snackbar("Sorry", "Please try again.",
                                            snackPosition:SnackPosition.BOTTOM,
                                            backgroundColor: Colors.red.withOpacity(0.1),
                                            colorText: Colors.red);


                                      }catch(error)
                                      {

                                      }

                                    }

                                  },)

                                ],
                              ), onClosing: () {  },));
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
                                    width: 30,
                                  ),
                                  Icon(Icons.insert_photo,color: Colors.white,),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Text("Image",style: TextStyle(color: Colors.white,fontSize: 18),),
                                ],
                              )                            ),
                          ),
                        ),
                      ),

                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 45.0),


                        child: Container(
                        width: 300,
                        height: 40,

                    child:Container(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        onPressed:()async {
              bool cnicCheck = await isCnicUnique(controller.Arcnic.text);
              if(cnicCheck)
              {
              Get.snackbar("Sorry", "Cnic already exists.",
              snackPosition:SnackPosition.BOTTOM,
              backgroundColor: Colors.red.withOpacity(0.1),
              colorText: Colors.red);
              controller.Arcnic.clear();

              }else{
              if(formkey.currentState!.validate())  {
              if(await Artist_Controller.instance.registerArtist(controller.Aremail.text.trim(), controller.Arpass.text.trim())){
              Artist_Controller.instance.registerArtist(controller.Aremail.text.trim(), controller.Arpass.text.trim());
              if(await myAuth.verifyOTP(otp:Otp.text) == true)
              {
              final artist = Artist_model(
              name: controller.Arname.text.trim(),
              email: controller.Aremail.text.trim(),
              cnic: controller.Arcnic.text.trim(),
              pass: controller.Arpass.text.trim(),
              url: controller.Artist_url);
              Artist_Controller.instance.createArtist(artist);
              Navigator.push(context, MaterialPageRoute(builder: (
              context) => Artist_login()),);
              controller.Arcnic.clear();
              controller.Arpass.clear();
              controller.Aremail.clear();
              controller.Arname.clear();
              }
              else{
              Get.snackbar("Sorry", "Enter the Valid Otp.",
              snackPosition:SnackPosition.BOTTOM,
              backgroundColor: Colors.red.withOpacity(0.1),
              colorText: Colors.red);
              }

              }
              else{
              Get.snackbar("Sorry", "Email is already registered.",
              snackPosition:SnackPosition.BOTTOM,
              backgroundColor: Colors.red.withOpacity(0.1),
              colorText: Colors.red);
              }




              }
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
                    Text("Register",style: TextStyle(color: Colors.white,fontSize: 18)),
                  ),
                ),
              ),
            ),

          ) )
                  ],
                ),
              ),
            ),
          )
        ],),
      ),

    );
  }

  Future<bool> isCnicUnique(String? cnic) async {
    if (cnic == null) {
      return false;
    }
    // Assuming you have a "artists" collection in Firestore


    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Artists')
          .where('Cnic', isEqualTo: cnic)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking if user is an artist: $e');
      return false;
    }
  }

}