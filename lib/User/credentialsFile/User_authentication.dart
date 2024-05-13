import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:takhleekish/User/dashboard/User_Dashboard.dart';
import 'package:takhleekish/User/userSignUpEmailFailure.dart';
import 'package:takhleekish/User/userPersonal/user_login.dart';

class User_Auth extends GetxController{
  static User_Auth get instance=> Get.find();

  final _auth=FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser=Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    // ever(firebaseUser, _setintial);
  }

  // _setintial(User? user) {
  //   user==null ? Get.offAll(()=> User_login()):Get.offAll(()=> User_dashboard());
  // }


  Future<void> createUserWithEmailandPass(String email,String pass)
  async {
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: pass);
    }on FirebaseAuthException catch(e)
    {
      final ex=UserSignUpFailure.code(e.code);
      print('FireBase ${ex.msg}');
      throw ex;
    }catch (_)
    {
      const ex=UserSignUpFailure();
      print('${ex.msg}');
      throw ex;

    }
  }

  Future<void>  SendUserEmailVerification() async{
    try{
      await _auth.currentUser?.sendEmailVerification();

    }on FirebaseAuthException catch(e)
    {
      final ex=UserSignUpFailure.code(e.code);
      print('FireBase ${ex.msg}');
      throw ex;
    }catch (_)
    {
      const ex=UserSignUpFailure();
      print('${ex.msg}');
      throw ex;

    }

  }

  Future<void> loginUserWithEmailandPass(String email,String pass)
  async {
    await _auth.signInWithEmailAndPassword(email: email, password: pass);
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}