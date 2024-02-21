import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sustainability/Services/Authentication.dart';
import 'package:sustainability/screens/buildingsPage.dart';
import 'package:sustainability/screens/mainScreen.dart';
import 'package:sustainability/screens/powerInputPage.dart';

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
                  Get.to(()=>PowerInputPage());
                },"Add Power Consumption Record"),
                buildWidget((){
                  Get.to(()=>BuildingPage());
                },"Manage Power Consumption Record"),
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
