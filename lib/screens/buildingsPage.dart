import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sustainability/controllers/powerController.dart';
import 'package:sustainability/screens/QrCodeScreen.dart';
import 'package:sustainability/screens/mainScreen.dart';
import 'package:sustainability/screens/widgets/loading.dart';

import '../Controllers/loading.dart';
import '../services/powerServices.dart';

class BuildingPage extends StatelessWidget {
  const BuildingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text("Building Selection Page"),
            actions: [
              IconButton(onPressed: (){
                Get.to(()=>QRCodeScreen());
              }, icon: Icon(Icons.qr_code_2))
            ],
          ),
          body: SingleChildScrollView(
            child: Wrap(
              children: List.generate(powerCntr.allBuildings!.value.length, (index) => GestureDetector(
                onTap: ()=>Get.to(()=>MainScreen(houseNo: powerCntr.allBuildings!.value[index].id.toString(), totalPowerConsp: powerCntr.allBuildings!.value[index].totalPowerConsp.toString(),)),
                child: SizedBox(
                  height: 250,
                  width: 200,
                  child: Column(
                    children: [
                      Icon(Icons.house,
                        size: 170,
                        color: double.parse(powerCntr.allBuildings!.value[index].totalPowerConsp.toString())<200000?Colors.green:double.parse(powerCntr.allBuildings!.value[index].totalPowerConsp.toString())<350000?Colors.yellow:Colors.red,),
                      Text(powerCntr.allBuildings!.value[index].id.toString(),style: TextStyle(
                        fontSize: 20,
                color: double.parse(powerCntr.allBuildings!.value[index].totalPowerConsp.toString())<200000?Colors.green:double.parse(powerCntr.allBuildings!.value[index].totalPowerConsp.toString())<350000?Colors.yellow:Colors.red,),
                ),
                      Visibility(
                          visible: FirebaseAuth.instance.currentUser?.email == "admin@sustainability.com",
                          child: IconButton(onPressed: (){
                            showDialog(context: context, builder: (ctx){
                              return AlertDialog(
                                title: Text("Deleting The Power Consumption Record"),
                                content: Text("Do you want to delete this record?"),
                                actions: [
                                  ElevatedButton(onPressed: ()=>PowerServices().deleteBuilding(powerCntr.allBuildings!.value[index].id.toString()), child: Text("Yes")),
                                  TextButton(onPressed: ()=>Get.back(), child: Text("No")),
                                ],
                              );
                            });
                          }, icon: Icon(Icons.delete,color: Colors.red,))),
                      SizedBox(width: 10.0,),
                    ],
                  ),
                ),
              )),
            ),
          ),
        ),
        !loading()?SizedBox():LoadingWidget()
      ],
    ));
  }
}
