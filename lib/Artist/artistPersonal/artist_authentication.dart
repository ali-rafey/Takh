import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:takhleekish/Artist/artistPersonal/signUpEmailPasswordFailure.dart';


class Artist_Auth extends GetxController{
  static Artist_Auth get instance=> Get.find();

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


  Future<void> createArtistWithEmailandPass(String email,String pass)
  async {

    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: pass);
    }on FirebaseAuthException catch(e)
    {
      final ex=SignUpFailure.code(e.code);
      print('FireBase ${ex.msg}');
      throw ex;
    }catch (_)
    {
      const ex=SignUpFailure();
      print('${ex.msg}');
      throw ex;

    }

   }


  Future<void> loginArtistWithEmailandPass(String email,String pass)
  async {
    await _auth.signInWithEmailAndPassword(email: email, password: pass);
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}