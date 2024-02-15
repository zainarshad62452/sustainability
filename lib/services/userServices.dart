import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Controllers/loading.dart';
import '../models/userModel.dart';
import '../screens/widgets/snackbar.dart';
import 'Reception.dart';


class UserServices {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

   registerUser({required String name, required User user,}) async {
    var x = UserModel(
        name: name,
        email: user.email,
        registeredOn: Timestamp.now(),
        uid: user.uid,
    );
    try {
      await firestore.collection("users").doc(user.uid).set(x.toJson());
      loading(false);
      Reception().userReception();
    } catch (e) {
      loading(false);
      alertSnackbar("Can't register user");
    }
  }

  Stream<UserModel>? streamUser()  {
    try{
      return firestore
          .collection("users")
          .doc(auth.currentUser!.uid)
          .snapshots()
          .map((event) {
        if(event.data()!=null){
          return UserModel.fromJson(event.data()!);
        }else{
          return UserModel();
        }
      });
    }catch(e){
      return null;
    }

  }
  Stream<UserModel>? streamSpecificUser(String id)  {
    try{
      return firestore
          .collection("users")
          .doc(id)
          .snapshots()
          .map((event) {
        if(event.data()!=null){
          print(UserModel.fromJson(event.data()!).name);
          return UserModel.fromJson(event.data()!);
        }else{
          return UserModel();
        }
      });
    }catch(e){
      return null;
    }

  }
  Stream<List<UserModel>>? streamAllAdmins() {
    try {
      return firestore.collection("users").snapshots().map((event) {
        loading(false);
        List<UserModel> list = [];
        event.docs.forEach((element) {
          final admin = UserModel.fromJson(element.data());
          list.add(admin);
        });
        loading(false);
        return list;
      });
    } catch (e) {
      loading(false);
      return null;
    }
  }
}
