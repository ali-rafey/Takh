import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takhleekish/User/dashboard/User_Dashboard.dart';
import 'package:takhleekish/User/controllers/login_controller.dart';
import 'package:takhleekish/User/controllers/user_controller.dart';
import 'package:takhleekish/User/forgot_Password/forgotPage.dart';
import 'package:takhleekish/User/userPersonal/user_signup.dart';
import 'package:takhleekish/main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class User_login extends StatefulWidget{
  const User_login({Key? key}) : super(key: key);
  @override
  State<User_login> createState() => _User_loginState();
}

class _User_loginState extends State<User_login> {
  @override
  Widget build(BuildContext context) {

    var flag=false;
    final formkey=GlobalKey<FormState>();
    final controller=Get.put(User_Controller());
    final LoginController loginController=LoginController();
    final errorText = Obx(() => Text(
      loginController.errorMessage.value,
      style: TextStyle(color: Colors.red),
    ));
   return(
   Scaffold(
     body: SingleChildScrollView(
       child: Center(
         child: Container(

           child: Form(
             key: formkey,
             child: Column(
               children: [
                 Container(
                   height: 300,
                   child:Center(
                     child:  Container(
                         width: 280,
                         height: 280,
                         child: Image.asset("assests/images/homeScreenPic.png")),
                   ),
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
                     borderRadius: BorderRadius.only(
                       bottomLeft: Radius.circular(50), // Adjust the radius as needed
                       bottomRight: Radius.circular(50), // Adjust the radius as needed
                     ),

                   ),

                 ),
                 SizedBox(height: 45,),
                 Container(
                   width: 340,
                   height: 45,
                   child: TextFormField(
                     controller: loginController.Usemail,
                     validator:(value){
                       if(value!.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}').hasMatch(value!))
                       {
                         return 'Enter correct Email';
                       }
                       else{
                         loginController.Usemail.text=value;
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
                     ),

                   ),
                 ),
                 Container(
                   height: 20,
                 ),
                 Container(
                   width: 340,
                   height: 45,
                   child: TextFormField(
                     controller: loginController.Uspass,
                     obscureText:true,
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
                   height: 20,
                 ),
                 Padding(
                   padding: const EdgeInsets.only(bottom: 0.0),
                   child: Container(
                       child: TextButton(onPressed: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>Forgot_Page()));
                       },
                           child:Text("Forgot Password?",style: TextStyle(color: Colors.blue,fontSize: 18),))),
                 ),
                 SizedBox(
                   height: 20,
                 ),
                 Padding(
                   padding: const EdgeInsets.only(bottom: 4.0),


                   child: Container(
                     width: 200,
                     height: 40,

                     child:Container(
                       width: double.infinity,
                       height: 50,
                       child: ElevatedButton(
                         onPressed:(){
                           if(formkey.currentState!.validate()) {
                             loginController.setOnLoginSuccess(() {
                               Get.offAll(()=>User_dashboard());
                             });
                             loginController.login();

                             loginController.Usemail.clear();
                             loginController.Uspass.clear();
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
                             Text("Login",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 20),),
                           ),
                         ),
                       ),
                     ),

                   ),),
                 errorText,
                 Row(
                   children: [
                     Padding(
                       padding: const EdgeInsets.only(left: 30.0),
                       child: Text("Don't have an account?",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18),),
                     ),
                     TextButton(onPressed: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=> User_Signup()),);
                     }, child: Text("Sign Up",style: TextStyle(color: Colors.blue,fontSize: 22,fontWeight: FontWeight.bold),))
                   ],
                 )
               ],
             ),
           ),
         ),

       ),
     )
   )
   );
  }
}