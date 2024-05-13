// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:takhleekish/User/user_model.dart';
//
// import '../controllers/user_controller.dart';
//
// class ResetPasssword extends StatelessWidget{
//   final formkey=GlobalKey<FormState>();
//   TextEditingController Usconfirmpass=TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     final controller=Get.put(User_Controller());
//     return Scaffold(
//       body: Container(
//           width: double.infinity,
//         height: double.infinity,
//         color: Colors.white,
//         child: SingleChildScrollView(
//           child: Form(
//             key: formkey,
//             child: Center(
//               child: Column(
//                 children: [
//                   SizedBox(height: 120,),
//                   Text("Takhleeqish",style: TextStyle(fontSize: 60,fontFamily:'main',fontWeight: FontWeight.w600),),
//                   SizedBox(
//                     height: 80,
//                   ),
//                   Text(
//                     "Reset Password",
//                     style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
//                   ),
//                   Text(
//                     "Reset your password here ",
//                     style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
//                   ),
//                   SizedBox(height: 40,),
//                   Container(
//                     width: 300,
//                     height: 50,
//                     child: TextFormField(
//                       controller:controller.Uspass,
//                       validator:(value){
//                         if(value!.isEmpty || !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value!))
//                         {
//                           return '8 digits,one (upper,lower case,digit,Special character)';
//                         }
//                         else{
//                           controller.Uspass.text=value;
//                         }
//                       },
//                       decoration: InputDecoration(
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15.0),
//                           borderSide: BorderSide(
//                             width: 2,
//                             color: Color(0xfff77062),
//                           ),
//
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15.0),
//                             borderSide: BorderSide(
//                               color: Colors.blue,
//                             )
//                         ),
//                         prefixIcon: Icon(Icons.lock,color: Colors.black,),
//                         label: Text("Password"),
//                         hintText: "Enter Password here"
//
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 30,),
//                   Container(
//                     width: 300,
//                     height: 50,
//                     child: TextFormField(
//                       controller:Usconfirmpass,
//                       decoration: InputDecoration(
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15.0),
//                             borderSide: BorderSide(
//                               width: 2,
//                               color: Color(0xfff77062),
//                             ),
//
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15.0),
//                               borderSide: BorderSide(
//                                 color: Colors.blue,
//                               )
//                           ),
//                           prefixIcon: Icon(Icons.lock,color: Colors.black,),
//                           label: Text("Confirm Password"),
//                           hintText: "Re-enter Password here"
//
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 50,),
//                   Container(
//                     width: 300,
//                     height: 40,
//                     child: ElevatedButton(
//                       onPressed: ()async {
//                         if(controller.Uspass.text==Usconfirmpass.text)
//                           {
//                             if(formkey.currentState!.validate())
//                             {
//                               final user=User_model.passwordOnly(controller.Uspass.text);
//                              await controller.updatePassword(user);
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(content:Text("Password Reset Successfully"), ));
//
//                             }
//                           }
//                         else{
//                           ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(content:Text("Enter same Password in both fields"), ));
//
//
//                         }
//
//
//                       },
//                       child: Text(
//                         "Reset",
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.w700,
//                             fontSize: 16),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue.withOpacity(0.5),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(15)),
//                       ),
//                     ),
//                   )
//
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
// }