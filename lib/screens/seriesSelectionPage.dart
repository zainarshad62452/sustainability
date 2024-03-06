import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sustainability/controllers/powerController.dart';
import 'package:sustainability/screens/QrCodeScreen.dart';
import 'package:sustainability/screens/buildingsPage.dart';
import 'package:sustainability/screens/mainScreen.dart';
import 'package:sustainability/screens/widgets/loading.dart';

import '../Controllers/loading.dart';
import '../services/powerServices.dart';

class SeriesSelectionPage extends StatelessWidget {
  const SeriesSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text("Series Selection Page"),
            actions: [
              IconButton(onPressed: (){
                Get.to(()=>QRCodeScreen());
              }, icon: Icon(Icons.qr_code_2))
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: List.generate(powerCntr.allSeries!.value.length, (index) => GestureDetector(
                onTap: ()=>Get.to(()=>BuildingPage(series: powerCntr.allSeries!.value[index].series.toString(),averagePowConsp: double.parse(powerCntr.allSeries!.value[index].averagePowerConsp.toString()),)),
                child: SizedBox(
                  height: 250,
                  width: double.maxFinite,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Icon(Icons.house,
                            size: 170,
                            color: double.parse(powerCntr.allSeries!.value[index].averagePowerConsp.toString())<1000000?Colors.green:double.parse(powerCntr.allSeries!.value[index].averagePowerConsp.toString())<1500000?Colors.yellow:Colors.red,),
                          Visibility(
                              visible: FirebaseAuth.instance.currentUser?.email == "admin@sustainability.com",
                              child: IconButton(onPressed: (){
                                showDialog(context: context, builder: (ctx){
                                  return AlertDialog(
                                    title: Text("Deleting The Series"),
                                    content: Text("Do you want to delete this series?"),
                                    actions: [
                                      ElevatedButton(onPressed: ()=>PowerServices().deleteSeries(powerCntr.allSeries!.value[index].series.toString()), child: Text("Yes")),
                                      TextButton(onPressed: ()=>Get.back(), child: Text("No")),
                                    ],
                                  );
                                });
                              }, icon: Icon(Icons.delete,color: Colors.red,))),
                          SizedBox(width: 10.0,),
                        ],
                      ),
                      Container(
                        height: 170,
                        decoration: BoxDecoration(
                          border: Border.all(color: double.parse(powerCntr.allSeries!.value[index].averagePowerConsp.toString())<1000000?Colors.green:double.parse(powerCntr.allSeries!.value[index].averagePowerConsp.toString())<1500000?Colors.yellow:Colors.red,)
                        ,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(powerCntr.allSeries!.value[index].series.toString(),style: TextStyle(
                              fontSize: 20,
                              color: double.parse(powerCntr.allSeries!.value[index].averagePowerConsp.toString())<1000000?Colors.green:double.parse(powerCntr.allSeries!.value[index].averagePowerConsp.toString())<1500000?Colors.yellow:Colors.red,),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Average Consumption:\n${powerCntr.allSeries!.value[index].averagePowerConsp.toString()}" ),
                            ),
                          ],
                        ),
                      ),
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
