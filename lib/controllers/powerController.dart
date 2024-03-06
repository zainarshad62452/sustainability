import 'package:get/get.dart';
import 'package:sustainability/models/buildingModel.dart';
import 'package:sustainability/models/powerModel.dart';
import 'package:sustainability/services/powerServices.dart';
import '../Services/userServices.dart';
import '../models/seriesModel.dart';
import '../models/userModel.dart';



final powerCntr = Get.find<PowerController>();

class PowerController extends GetxController {
  RxList<PowerModel>? allPowers = <PowerModel>[].obs;
  RxList<BuildingModel>? allBuildings = <BuildingModel>[].obs;
  RxList<SeriesModel>? allSeries = <SeriesModel>[].obs;
  RxList<String>? allYears = <String>[].obs;
  RxList<String>? allHouses = <String>[].obs;
  Rx<String> selectedValue = "".obs;
  Rx<String> selectedHouseValue = "".obs;
  @override
  void onReady() {
    initAdminStream();
  }



  initAdminStream() async {
    allPowers!.bindStream(PowerServices().streamAllPower()!);
    allBuildings!.bindStream(PowerServices().streamAllBuildings()!);
    allSeries!.bindStream(PowerServices().streamAllSeries()!);
  }
}
