import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sustainability/Controllers/loading.dart';
import 'package:sustainability/controllers/powerController.dart';
import 'package:sustainability/models/powerModel.dart';
import 'package:sustainability/screens/powerConsPage.dart';
import 'package:sustainability/screens/widgets/loading.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MainScreen extends StatelessWidget {
  final PowerController powerCntr = Get.put(PowerController());
  String houseNo;
  var color = Colors.green.shade800.obs;
  MainScreen({required this.houseNo});


  @override
  Widget build(BuildContext context) {
    return GetBuilder<PowerController>(
      init: powerCntr,
      initState: (_) {
        // double total = double.parse(powerCntr.allPowers?.value
        //     .where((element) =>
        // element.year == powerCntr.selectedValue.value &&
        //     element.houseNo == houseNo)
        //     .first.totalPowerConsp.toString()??"0.0");
        // color.value = total<200000?Colors.green:total<350000?Colors.yellow:Colors.red;
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
                            .first, isAdmin: FirebaseAuth.instance.currentUser!=null, color: color.value,
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
}


