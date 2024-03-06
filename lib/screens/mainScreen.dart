import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sustainability/Controllers/loading.dart';
import 'package:sustainability/controllers/powerController.dart';
import 'package:sustainability/models/powerModel.dart';
import 'package:sustainability/screens/powerConsPage.dart';
import 'package:sustainability/screens/widgets/loading.dart';
import 'package:sustainability/services/powerServices.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MainScreen extends StatelessWidget {
  final PowerController powerCntr = Get.put(PowerController());
  String houseNo,totalPowerConsp;
  double averagePowerConsp;
  var color = Colors.green.shade800.obs;
  MainScreen({required this.houseNo,required this.totalPowerConsp,required this.averagePowerConsp});


  @override
  Widget build(BuildContext context) {
    return GetBuilder<PowerController>(
      init: powerCntr,
      initState: (_) {
        powerCntr.allYears?.value = getValues();
        powerCntr.selectedValue.value = powerCntr.allYears!.value.first??"";
        Future.delayed(Duration(seconds: 3));
      },
      builder: (controller) {
        return Obx(() => Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                backgroundColor: color.value,
                title: Text("MainScreen",style: TextStyle(color: color.value==Colors.yellow?Colors.black:Colors.white),),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      value: powerCntr.selectedValue.value,
                      items: powerCntr.allYears?.value
                          .map((e) => DropdownMenuItem(
                        child: Text("${e}"),
                        value: e,
                      ))
                          .toList(),
                      onChanged: (value) {
                        powerCntr.selectedValue.value = value!;
                        // double total = double.parse(powerCntr.allPowers!.value
                        //     .where((element) =>
                        // element.year == powerCntr.selectedValue.value &&
                        //     element.houseNo == houseNo)
                        //     .first.totalPowerConsp.toString());
                        // color.value = total<200000?Colors.green:total<350000?Colors.yellow:Colors.red;
                      },
                    ),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    if (powerCntr.allPowers?.value != null &&
                        powerCntr.allPowers!.value
                            .where((element) =>
                        element.year == powerCntr.selectedValue.value &&
                            element.houseNo == houseNo)
                            .isNotEmpty)
                      PowerConsumptionPage(
                        powerModel: powerCntr.allPowers!.value
                            .where((element) =>
                        element.year == powerCntr.selectedValue.value &&
                            element.houseNo == houseNo)
                            .first, isAdmin: FirebaseAuth.instance.currentUser!=null, color: color.value, totalPowerConsp: totalPowerConsp, averagePowerConsp: averagePowerConsp,
                      )
                    else
                      Center(child: Text("No Data Found")),
                  ],
                ),
              ),
            ),
            !loading() ? SizedBox() : LoadingWidget(),
          ],
        ));
      },
    );
  }

  List<String> getValues(){
    List<String> allValues = [];
    final data = powerCntr.allPowers?.value;
    for (var dat in data!){
      if(dat.houseNo == houseNo){
        if(!allValues.contains(dat.year)){
        allValues.add(dat.year.toString());
        }
      }
    }
    return allValues;
  }
}


