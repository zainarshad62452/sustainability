import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sustainability/controllers/powerController.dart';
import 'package:sustainability/models/buildingModel.dart';
import 'package:sustainability/models/powerModel.dart';
import '../Controllers/loading.dart';
import '../screens/widgets/snackbar.dart';

class PowerServices {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  Future<void> addPower({required PowerModel powerModel}) async {
    try {
      final powerCollection = firestore
          .collection("power_consumption")
          .doc(powerModel.houseNo)
          .collection("power_consumption");

      final buildingDoc = firestore.collection("power_consumption").doc(powerModel.houseNo);
      final buildingSnapshot = await buildingDoc.get();
      double totalPowerConsp = double.parse(powerModel.totalPowerConsp.toString());

      // If building exists, calculate average totalPowerConsp
      if (buildingSnapshot.exists) {
        final buildingData = buildingSnapshot.data() as Map<String, dynamic>;
        final existingTotalPowerConsp = double.parse(buildingData['totalPowerConsp'].toString()) ?? 0.0;
        final totalCount = (buildingData['powerCount'] ?? 0) + 1;
        totalPowerConsp = (existingTotalPowerConsp + double.parse(powerModel.totalPowerConsp.toString())) / totalCount;

        // Update totalPowerConsp and increment powerCount in building document
        await buildingDoc.update({
          'totalPowerConsp': totalPowerConsp.toString(),
          'powerCount': totalCount,
        });
      } else {
        // Set totalPowerConsp and initialize powerCount in building document
        await buildingDoc.set({
          'id':powerModel.houseNo,
          'totalPowerConsp': totalPowerConsp,
          'powerCount': 1,
        });
      }

      // Add powerModel to power_consumption collection
      await powerCollection.doc(powerModel.year.toString()).set(powerModel.toJson());

      Get.back();
      snackbar("Done", "Power Added Successfully");
      loading(false);
    } catch (e) {
      loading(false);
      alertSnackbar("Can't add Power Consumption");
    }
  }

  Stream<List<PowerModel>>? streamAllPower() {
    try {
      return firestore.collectionGroup("power_consumption").snapshots().asyncMap((event) async {
        loading(false);
        List<PowerModel> list = [];
        List<BuildingModel> buildings = [];
        List<String> allYears = [];
        List<String> allHouses = [];
        print(buildings.length);
        event.docs.forEach((element) {
          final admin = BuildingModel.fromJson(element.data());
          buildings.add(admin);
        });
        for (var buildingDoc in buildings) {
          final buildingId = buildingDoc.id;
          print("////////////////////////////////");
          print(buildingDoc.id);
          if(buildingId!=null){
            final powerSnapshot = await firestore.collection("power_consumption").doc(buildingId).collection("power_consumption").get();
            powerSnapshot.docs.forEach((powerDoc) {
              final powerData = powerDoc.data();
              final powerModel = PowerModel.fromJson(powerData);
              if (!allYears.contains(powerModel.year)) {
                allYears.add(powerModel.year!);
              }
              if (!allHouses.contains(powerModel.houseNo)) {
                allHouses.add(powerModel.houseNo!);
              }
              list.add(powerModel);
            });
            powerCntr.allYears?.value = allYears;
            powerCntr.allHouses?.value = allHouses;
            powerCntr.selectedValue.value = allYears.first;
            powerCntr.selectedHouseValue.value = allHouses.first;
          }
        }
        loading(false);
        return list;
      });
    } catch (e) {
      loading(false);
      return null;
    }
  }


  Stream<List<BuildingModel>>? streamAllBuildings() {
    try {
      return firestore.collection("power_consumption").snapshots().map((event) {
        loading(false);
        List<BuildingModel> list = [];
        event.docs.forEach((element) {
          final admin = BuildingModel.fromJson(element.data());
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
    try {
      await firestore.collection("power_consumption").doc(powerModel.houseNo).collection("power_consumption").doc(powerModel.id).update(powerModel.toJson());
      Get.back();
      snackbar("Done", "Edited Successfully");
      loading(false);
    } catch (e) {
      alertSnackbar(e.toString());
    }
  }

  Future<void> deletePower(PowerModel powerModel) async {
    try {
      loading(true);
      await firestore.collection("power_consumption").doc(powerModel.houseNo).collection("power_consumption").doc(powerModel.id).delete();
      Get.back();
      Get.back();
      snackbar("Done", "The Power of ${powerModel.houseNo} of ${powerModel.year} deleted successfully");
      loading(false);
    } catch (e) {
      alertSnackbar(e.toString());
    }
  }
}
