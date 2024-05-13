//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:takhleekish/Artist/throughDashboard/artistDashboard.dart';
// import 'package:takhleekish/Artist/artistDatabase.dart';
// import 'package:takhleekish/Artist/artist_model.dart';
// import 'package:takhleekish/Artist/controllers/artist_controller.dart';
//
// import '../../artifacts/artifactController.dart';
// import '../../artifacts/artifactModel.dart';
// import '../../artist_authentication.dart';
// import '../../artist_repository.dart';
//
// class Demo extends StatelessWidget {
//   final formkey=GlobalKey<FormState>();
//   final authrepo = Get.put(Artist_Auth());
//   final artistRepo = Get.put(Artist_repo());
//   var Arcnic;
//
//   @override
//   Widget build(BuildContext context) {
//
//     double screenHeight=MediaQuery.of(context).size.height;
//     final controller=Get.put(Artifact_Controller());
//     return Drawer(
//       child: FutureBuilder(
//         future: getData(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.hasData) {
//               Artist_model artistModel = snapshot.data as Artist_model;
//               //     Text("$email"),
//               // Text("$name"),
//
//               return Container(
//                 width: double.infinity,
//                 height: double.infinity,
//                 color: Colors.white,
//                 child: SingleChildScrollView(
//                   child: Form(
//                     key: formkey,
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           height: screenHeight * 0.05,
//                         ),
//                         Icon(Icons.upload_file, size: 80,),
//                         SizedBox(
//                           height: screenHeight * 0.05,
//                         ),
//                         Container(
//                           width: 300,
//                           height: 50,
//                           child: TextFormField(
//                             controller: controller.Artifact_name,
//                             keyboardType: TextInputType.name,
//                             validator: (value) {
//                               if (value!.isEmpty ||
//                                   !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
//                                 return 'Enter correct name';
//                               }
//                               else {
//                                 controller.Artifact_name.text = value;
//                               }
//                             },
//                             decoration: InputDecoration(
//                               focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(15.0),
//                                   borderSide: BorderSide(
//                                     width: 2,
//                                     color: Color(0xfff77062),
//                                   )
//
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(15.0),
//                                   borderSide: BorderSide(
//                                     color: Colors.blue,
//                                   )
//                               ),
//                               prefixIcon: Icon(Icons.drive_file_rename_outline),
//                               labelText: "Enter Full Name",
//                             ),
//
//                           ),
//                         ),
//                         SizedBox(
//                           height: screenHeight * 0.02,
//                         ),
//                         Container(
//                           width: 300,
//                           height: 50,
//                           child: TextFormField(
//                             controller: controller.Artifact_price,
//                             keyboardType: TextInputType.number,
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return 'Please enter the price';
//                               }
//                               else {
//                                 controller.Artifact_price.text = value;
//                               }
//                             },
//                             decoration: InputDecoration(
//                               focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(15.0),
//                                   borderSide: BorderSide(
//                                     width: 2,
//                                     color: Color(0xfff77062),
//                                   )
//
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(15.0),
//                                   borderSide: BorderSide(
//                                     color: Colors.blue,
//                                   )
//                               ),
//                               prefixIcon: Icon(
//                                 Icons.currency_exchange, color: Colors.black,),
//                               labelText: "Enter Price",
//                             ),
//
//                           ),
//                         ),
//                         SizedBox(
//                           height: screenHeight * 0.02,
//                         ),
//                         Container(
//                           width: 300,
//                           height: 50,
//                           child: TextFormField(
//                             initialValue: artistModel.cnic,
//                             keyboardType: TextInputType.name,
//                             validator: (value) {
//                               if (value!.isEmpty ||
//                                   !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
//                                 return 'Enter correct name';
//                               }
//                               else {
//                                 controller.Artifact_name.text = value;
//                               }
//                             },
//                             decoration: InputDecoration(
//                               focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(15.0),
//                                   borderSide: BorderSide(
//                                     width: 2,
//                                     color: Color(0xfff77062),
//                                   )
//
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(15.0),
//                                   borderSide: BorderSide(
//                                     color: Colors.blue,
//                                   )
//                               ),
//                               prefixIcon: Padding(
//                                 padding: const EdgeInsets.only(left: 12.0,top: 10.0),
//                                 child: Container(child: FaIcon(FontAwesomeIcons.idBadge,color: Colors.black,)),
//                               ),
//                               labelText: "Enter Artist Cnic",
//                             ),
//
//                           ),
//                         ),
//                         SizedBox(
//                           height: screenHeight * 0.02,
//                         ),
//                         Container(
//                           width: 300,
//                           height: 50,
//                           child: TextFormField(
//                             controller: controller.Artifact_category,
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return 'Enter the category';
//                               }
//                               else {
//                                 controller.Artifact_category.text = value;
//                               }
//                             },
//                             decoration: InputDecoration(
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(15.0),
//                                 borderSide: BorderSide(
//                                   width: 2,
//                                   color: Color(0xfff77062),
//                                 ),
//
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(15.0),
//                                   borderSide: BorderSide(
//                                     color: Colors.blue,
//                                   )
//                               ),
//                               prefixIcon: Icon(
//                                 Icons.category_outlined, color: Colors.black,),
//
//                               labelText: "Enter Category",
//
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: screenHeight * 0.02,
//                         ),
//                         Container(
//                           width: 300,
//                           height: 60,
//                           child: TextFormField(
//                             controller: controller.Artifact_desc,
//                             expands: true,
//                             maxLines: null,
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return 'Enter the description';
//                               }
//                               else {
//                                 controller.Artifact_desc.text = value;
//                               }
//                             },
//                             decoration: InputDecoration(
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(15.0),
//                                 borderSide: BorderSide(
//                                   width: 2,
//                                   color: Color(0xfff77062),
//                                 ),
//
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(15.0),
//                                   borderSide: BorderSide(
//                                     color: Colors.blue,
//                                   )
//                               ),
//                               prefixIcon: Icon(
//                                 Icons.description, color: Colors.black,),
//                               labelText: "Enter Description",
//
//                             ),
//                           ),
//                         ),
//                         Padding(
//                             padding: const EdgeInsets.only(top: 45.0),
//                             child: Container(
//                               width: 300,
//                               height: 40,
//                               child: ElevatedButton(onPressed: () {
//                                 final artifact = Artifact_model(
//                                     name: controller.Artifact_name.text.trim(),
//                                     price: controller.Artifact_price.text.trim(),
//                                     category: controller.Artifact_category.text
//                                         .trim(),
//                                     description: controller.Artifact_desc.text.trim(),
//                                     ArtistId: artistModel.cnic.trim());
//
//                                 Artifact_Controller.instance.createArtifactt(
//                                     artifact);
//                                 Navigator.push(context, MaterialPageRoute(
//                                     builder: (context) => ArtistDashboard()),);
//                               }, child: Text("Register"),
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.blue.withOpacity(0.5),
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(15)
//                                   ),
//                                 ),
//                               ),
//                             ))
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             } else if (snapshot.hasError) {
//               return Text('User not found');
//             } else {
//               return Text('Something went wrong');
//             }
//           } else {
//             // Return Center widget to display CircularProgressIndicator in the center
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//     );
//   }
//
//   Future<Artist_model?> getData() async {
//     final email = authrepo.firebaseUser.value?.email;
//     if (email != null) {
//       return await artistRepo.getArtistDetail(email);
//     }
//     return null; // Handle the case where email is null
//   }
// }
