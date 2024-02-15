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
  final PowerController powerCntr = Get.put(PowerController()); // Ensure PowerController is properly defined


  @override
  Widget build(BuildContext context) {
    return GetBuilder<PowerController>(
      init: powerCntr,
      initState: (_) {
      },
      builder: (controller) {
        return Obx(() => Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                title: Text("MainScreen"),
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
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      value: powerCntr.selectedHouseValue.value,
                      items: powerCntr.allHouses?.value
                          .map((e) => DropdownMenuItem(
                        child: Text("${e}"),
                        value: e,
                      ))
                          .toList(),
                      onChanged: (value) {
                        powerCntr.selectedHouseValue.value = value!;
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
                            element.houseNo == powerCntr.selectedHouseValue.value)
                            .isNotEmpty)
                      PowerConsumptionPage(
                        powerModel: powerCntr.allPowers!.value
                            .where((element) =>
                        element.year == powerCntr.selectedValue.value &&
                            element.houseNo == powerCntr.selectedHouseValue.value)
                            .first, isAdmin: FirebaseAuth.instance.currentUser!=null,
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


