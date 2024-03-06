import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sustainability/Services/Authentication.dart';
import 'package:sustainability/screens/buildingsPage.dart';
import 'package:sustainability/screens/mainScreen.dart';
import 'package:sustainability/screens/powerInputPage.dart';
import 'package:sustainability/screens/seriesInputPage.dart';
import 'package:sustainability/screens/seriesSelectionPage.dart';

import 'addPowerByCsv.dart';

class AdminMainPage extends StatelessWidget {
  const AdminMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin HomePage"),
        actions: [
          IconButton(onPressed: ()=>Authentication().signOut(), icon: Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.maxFinite,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildWidget((){
                  showDialog(context: context, builder: (ctx)=>AlertDialog(title: Text("Select the action"),actions: [
                    TextButton(onPressed: ()=>Get.back(), child: Text("Cancel")),
                    ElevatedButton(onPressed: ()=>Get.to(()=>PowerInputPage()), child: Text("Add Power Consumption")),
                    ElevatedButton(onPressed: ()=>Get.to(()=>SeriesInputPage()), child: Text("Add Series")),
                  ],));
                  // Get.to(()=>PowerInputPage());
                },"Add Power Consumption Record"),
                buildWidget((){
                  Get.to(()=>SeriesSelectionPage());
                },"Manage Power Consumption Record"),
                buildWidget((){
                  Get.to(()=>FilePickerPage());
                },"Upload Excel"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildWidget(onTap,title) {
    return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: onTap,
                child: Container(
                  height: 200,
                  width: double.maxFinite,
                  decoration:  BoxDecoration(
                    color: Colors.black12,
                    border: Border.all(color: Colors.black54),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Center(child: Text(title)),
                ),
              ),
            );
  }
}
