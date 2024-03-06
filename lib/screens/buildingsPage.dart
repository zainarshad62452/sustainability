import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sustainability/controllers/powerController.dart';
import 'package:sustainability/screens/QrCodeScreen.dart';
import 'package:sustainability/screens/mainScreen.dart';
import 'package:sustainability/screens/widgets/loading.dart';

import '../Controllers/loading.dart';
import '../services/powerServices.dart';

class BuildingPage extends StatelessWidget {
  String series;
  double averagePowConsp;
   BuildingPage({super.key,required this.series,required this.averagePowConsp});

  @override
  Widget build(BuildContext context) {
    int start = 0;
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
            child: Stack(
              children: [
                Wrap(
                  children: List.generate(powerCntr.allBuildings!.value.length, (index) {
                    if(powerCntr.allBuildings!.value[index].series!.toLowerCase().contains(series.toLowerCase())){
                      start++;
                      return GestureDetector(
                        onTap: ()=>Get.to(()=>MainScreen(houseNo: powerCntr.allBuildings!.value[index].id.toString(), totalPowerConsp: powerCntr.allBuildings!.value[index].totalPowerConsp.toString(),averagePowerConsp: averagePowConsp,)),
                        child: SizedBox(
                          height: 250,
                          width: 200,
                          child: Column(
                            children: [
                              Icon(Icons.house,
                                size: 170,
                                color: getColor(series, double.parse(powerCntr.allBuildings!.value[index].totalPowerConsp.toString()))),
                              Text(powerCntr.allBuildings!.value[index].id.toString(),style: TextStyle(
                                fontSize: 20,
                                color: getColor(series, double.parse(powerCntr.allBuildings!.value[index].totalPowerConsp.toString()))),
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
                      );
                    }else{
                      return SizedBox();
                    }
                  }),
                ),
                Visibility(
                  visible:start==0,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 300.0),
                    child: Center(child: Text("No $series available")),
                  ),
                )
              ],
            ),
          ),
        ),
        !loading()?SizedBox():LoadingWidget()
      ],
    ));
  }
  Color getColor(String series, double totalPower){
    if(series == "A Series"){
      if(totalPower<500000){
        return Colors.green;
      }else if(totalPower<700000){
        return Colors.yellow;
      }else{
        return Colors.red;
      }
    }else if(series == "B Series"){
      if(totalPower<1000000){
        return Colors.green;
      }else if(totalPower<2000000){
        return Colors.yellow;
      }else{
        return Colors.red;
      }
    } else if(series == "C Series"){
      if(totalPower<800000){
        return Colors.green;
      }else if(totalPower<1000000){
        return Colors.yellow;
      }else{
        return Colors.red;
      }
    } else if(series == "D Series"){
      if(totalPower<1800000){
        return Colors.green;
      }else if(totalPower<2100000){
        return Colors.yellow;
      }else{
        return Colors.red;
      }
    } else if(series == "E1(IT) Series"){
      if(totalPower<9000000){
        return Colors.green;
      }else if(totalPower<10000000){
        return Colors.yellow;
      }else{
        return Colors.red;
      }
    } else if(series == "E Series"){
      if(totalPower<1200000){
        return Colors.green;
      }else if(totalPower<1400000){
        return Colors.yellow;
      }else{
        return Colors.red;
      }
    } else if(series == "F Series"){
      if(totalPower<1200000){
        return Colors.green;
      }else if(totalPower<2000000){
        return Colors.yellow;
      }else{
        return Colors.red;
      }
    } else if(series == "G Series"){
      if(totalPower<850000){
        return Colors.green;
      }else if(totalPower<950000){
        return Colors.yellow;
      }else{
        return Colors.red;
      }
    }else{
      if(totalPower<1800000){
        return Colors.green;
      }else if(totalPower<2000000){
        return Colors.yellow;
      }else{
        return Colors.red;
      }
    }
  }

}
