import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sustainability/models/powerModel.dart';
import 'package:sustainability/screens/editPowerPage.dart';
import 'package:sustainability/screens/tipsPage.dart';
import 'package:sustainability/services/powerServices.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PowerConsumptionPage extends StatelessWidget {
  PowerModel powerModel;
  bool isAdmin;
  String totalPowerConsp;
  Color color;

  PowerConsumptionPage({required this.powerModel,required this.isAdmin,required this.color,required this.totalPowerConsp});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Visibility(
          visible: FirebaseAuth.instance.currentUser?.email == "admin@sustainability.com",
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
            IconButton(onPressed: (){
              Get.to(EditPowerPage(powerModel: powerModel));
            }, icon: Icon(Icons.edit)),
            IconButton(onPressed: (){
              showDialog(context: context, builder: (ctx){
                return AlertDialog(
                  title: Text("Deleting The Power Consumption Record"),
                  content: Text("Do you want to delete this record?"),
                  actions: [
                    ElevatedButton(onPressed: ()=>PowerServices().deletePower(powerModel), child: Text("Yes")),
                    TextButton(onPressed: ()=>Get.back(), child: Text("No")),
                  ],
                );
              });
            }, icon: Icon(Icons.delete,color: Colors.red,)),
          ],),
        ),
        GestureDetector(
          onTap: ()=>Get.to(()=>TipsPage(totalConsp:
          double.parse(totalPowerConsp)
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.lightbulb_circle_outlined,color: double.parse(totalPowerConsp.toString())<200000?Colors.green.shade800:double.parse(totalPowerConsp.toString())<350000?Colors.yellow:Colors.red,size: 50.0,),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:15.0),
                    child: Text("Tips",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
            ],
          ),
        ),
        Text(powerModel.houseNo.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: double.parse(totalPowerConsp.toString())<200000?Colors.green.shade800:double.parse(totalPowerConsp.toString())<350000?Colors.yellow:Colors.red),),
        Container(
          height: 300,
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            series: <CartesianSeries>[
              LineSeries<PowerData, String>(
                dataSource: powerModel.powerConsumption?.asMap().entries.map((e) => PowerData(e.key, double.parse(e.value.toString()))).toList(),
                xValueMapper: (PowerData power, _) => powerModel.dates?[power.index],
                yValueMapper: (PowerData power, _) => power.value,
                color: color,
                markerSettings: MarkerSettings(isVisible: true,color: color),
              ),
            ],
          ),
        ),
        Divider(
          height: 5.0,
          thickness: 5.0,
          color: Colors.black54,
          indent: 30.0,
          endIndent: 30.0,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customWidget('Total Power Consumption (kW)',"${powerModel.totalPowerConsp} kW",Icons.show_chart),
              SizedBox(height: 16),
              customWidget('Carbon FootPrints (tCO2e)',"${((double.parse(powerModel.totalPowerConsp.toString())*0.21233)/1000)} tCO2e",Icons.energy_savings_leaf_outlined),
              SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }

  Padding customWidget(String heading, String amount, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Row(
          children: [
            Icon(icon,color: color==Colors.yellow?Colors.black:Colors.white,),
            Expanded(
              child: Column(
                children: [
                  Text(
                    heading,
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,color: color==Colors.yellow?Colors.black:Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(amount,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,color: color==Colors.yellow?Colors.black:Colors.white),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PowerData {
  final int index;
  final double value;

  PowerData(this.index, this.value);
}
