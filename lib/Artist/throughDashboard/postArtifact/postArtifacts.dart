
import 'dart:io';
import 'package:mailer/mailer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:takhleekish/Artist/artifacts/artifactController.dart';
import 'package:takhleekish/Artist/Navbar/navbar.dart';
import 'package:takhleekish/Artist/Dashboard/artistDashboard.dart';
import '../../artifacts/artifactModel.dart';
import '../../artistPersonal/artist_authentication.dart';
import '../../artistPersonal/artist_model.dart';
import '../../artistPersonal/artist_repository.dart';
import '../../controllers/artist_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mailer/smtp_server.dart';


class PostArtifact extends StatefulWidget{
  @override
  State<PostArtifact> createState() => _PostArtifactState();
}

class _PostArtifactState extends State<PostArtifact> {
  String imageurl='';
  final formkey=GlobalKey<FormState>();
  List<String> paintingCategories = [
    'Abstract',
    'Landscape',
    'Portrait',
    'Still Life',
    'Modern Art',
    'Contemporary',
  ];
  final authrepo = Get.put(Artist_Auth());

  final artistRepo = Get.put(Artist_repo());

  var Arcnic;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final controller = Get.put(Artifact_Controller());

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
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenHeight * 0.1,
                        ),
                        Icon(Icons.upload_file, size: 80,),
                        SizedBox(
                          height: screenHeight * 0.05,
                        ),
                        Container(
                          width: 200,
                          height: 40,
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
                                        Reference refrenceDirImage=refrenceRoot.child("products");
                                        Reference refrenceImageToUpload=refrenceDirImage.child(uniqueName);

                                        try{
                                          SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
                                          await refrenceImageToUpload.putFile(File(file!.path), metadata);
                                          imageurl=await refrenceImageToUpload.getDownloadURL();
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
                                          Reference refrenceDirImage=refrenceRoot.child('products');
                                          Reference refrenceImageToUpload=refrenceDirImage.child(uniqueName);

                                          try{
                                            SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
                                            await refrenceImageToUpload.putFile(File(file!.path), metadata);
                                            imageurl=await refrenceImageToUpload.getDownloadURL();
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
                                  ), onClosing: () {  },)
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
                                  child:
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Icon(Icons.insert_photo,color: Colors.white,),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Text("Image",style: TextStyle(color: Colors.white,fontSize: 18),),
                                    ],
                                  )                                ),
                              ),
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
                            controller: controller.Artifact_name,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
                                return 'Enter correct name';
                              }
                              else {
                                controller.Artifact_name.text = value;
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
                              prefixIcon: Icon(Icons.drive_file_rename_outline),
                              label:Text("Enter Full Name") ,
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
                            controller: controller.Artifact_price,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the price';
                              }
                              else {
                                controller.Artifact_price.text = value;
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
                              prefixIcon: Icon(
                                Icons.currency_exchange, color: Colors.black,),
                              label:Text("Enter Price") ,
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
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Container(
                          width: 300,
                          height: 70,
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(labelText: 'Painting Category'
                                , enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                      color: Colors.blue,
                                    )
          
                                )
                            ),
                            value: paintingCategories.first, // Initial value, you can change it accordingly
                            items: paintingCategories
                                .map((category) => DropdownMenuItem(
                              value: category,
                              child: Text(category),
                            ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                controller.Artifact_category.text = value as String;
                              });// Handle the painting category change
                            },
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Container(
                          width: 300,
                          height: 70,
                          child: TextFormField(
                            controller: controller.Artifact_desc,
                            expands: true,
                            maxLines: null,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter the description';
                              }
                              else {
                                controller.Artifact_desc.text = value;
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
                              prefixIcon: Icon(
                                Icons.description, color: Colors.black,),
                              label:Text("Enter Description") ,
          
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),





                        Padding(
                            padding: const EdgeInsets.only(top: 45.0),
                            child:
                            Container(
                              width: 300,
                              height: 40,
                              child:Container(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed:()  {
                                    if (formkey.currentState!.validate()){
                                      print('${controller.Artifact_name}');
                                      final artifact = Artifact_model(
                                          name: controller.Artifact_name.text.trim(),
                                          price: controller.Artifact_price.text.trim(),
                                          category: controller.Artifact_category.text
                                              .trim(),
                                          description: controller.Artifact_desc.text.trim(),
                                          ArtistId: controller.Artist_id.text.trim(),
                                          url:imageurl, cartCheck: 'false', likes: '0', saleCheck: 'false');
                                      Artifact_Controller.instance.createArtifactt(
                                          artifact);
                                      Get.snackbar("Congratulations", "Product has been added",
                                          snackPosition:SnackPosition.BOTTOM,
                                          backgroundColor: Colors.green.withOpacity(0.1),
                                          colorText: Colors.green);

                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) => ArtistDashboard()),);
                                      controller.Artist_id.clear();
                                      controller.Artifact_desc.clear();
                                      controller.Artifact_category.clear();
                                      controller.Artifact_price.clear();
                                      controller.Artifact_name.clear();

                                    }
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
                                      child:
                                      Text("Register",style: TextStyle(color: Colors.white,fontSize: 18),),
                                    ),
                                  ),
                                ),
                              ),

                            )),

                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
  Future pickImageFromGallery()async{
    final returnImage= await ImagePicker().pickImage(source: ImageSource.gallery);
  }
  // String mail,String name


}