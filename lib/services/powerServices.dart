import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sustainability/controllers/powerController.dart';
import 'package:sustainability/models/powerModel.dart';
import '../Controllers/loading.dart';
import '../screens/widgets/snackbar.dart';


class PowerServices {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  addPower({required PowerModel powerModel}) async {
    var x = powerModel;
    try {
      final data = firestore.collection("power_consumption").doc();
      x.id = data.id;
      data.set(x.toJson()).then((value) {
      Get.back();
      snackbar("Done", "Power Added Successfully");
      loading(false);
      });
    } catch (e) {
      loading(false);
      alertSnackbar("Can't add Power Consumption");
    }
  }
  Stream<List<PowerModel>>? streamAllPower() {
    try {
      return firestore.collection("power_consumption").snapshots().map((event) {
        loading(false);
        List<PowerModel> list = [];
        List<String> allYears = [];
        List<String> allHouses = [];
        event.docs.forEach((element) {
          final admin = PowerModel.fromJson(element.data());
          if(!allYears.contains(admin.year)){
            allYears.add(admin.year!);
          }
          if(!allHouses.contains(admin.houseNo)){
            allHouses.add(admin.houseNo!);
          }
          powerCntr.allYears?.value = allYears;
          powerCntr.allHouses?.value = allHouses;
          powerCntr.selectedValue?.value = allYears.first;
          powerCntr.selectedHouseValue?.value = allHouses.first;
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

  Future<void> updatePower(PowerModel powerModel) async {
    try{
      await firestore.collection("power_consumption").doc(powerModel.id).update(powerModel.toJson());
      Get.back();
      snackbar("Done", "Edited Successfully");
      loading(false);
    }catch(e){
      alertSnackbar(e.toString());
    }
  }

  Future<void> deletePower(PowerModel powerModel) async {
    try{
      loading(true);
      await firestore.collection("power_consumption").doc(powerModel.id).delete().then((value) {
      Get.back();
      Get.back();
      snackbar("Done", "The Power of ${powerModel.houseNo} of ${powerModel.year} deleted successfully");
      loading(false);
      });
    }catch(e){
      alertSnackbar(e.toString());
    }
  }
}
