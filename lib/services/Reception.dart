import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sustainability/screens/auth/emailVerification.dart';
import '../controllers/userController.dart';
import '../screens/adminMainPage.dart';
import '../screens/auth/signIn.dart';
import 'Authentication.dart';
class Reception{
final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  userReception() async {
    final type = "";
    print(type);
    if(FirebaseAuth.instance.currentUser!=null){
        if (FirebaseAuth.instance.currentUser!.email == "admin@sustainability.com") {
          Get.put(UserController());
          Get.offAll(()=>AdminMainPage());
        }else{
          Authentication().signOut();
        }
    }else{
      Get.offAll(() => SignIn());
    }
  }
}
