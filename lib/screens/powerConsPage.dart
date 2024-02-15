import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sustainability/models/powerModel.dart';
import 'package:sustainability/screens/editPowerPage.dart';
import 'package:sustainability/services/powerServices.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PowerConsumptionPage extends StatelessWidget {
  PowerModel powerModel;
  bool isAdmin;

  PowerConsumptionPage({required this.powerModel,required this.isAdmin});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Visibility(
          visible: isAdmin,
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
        Text('${powerModel.year} Power Consumption (kW)',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
        Container(
          height: 300,
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            series: <CartesianSeries>[
              LineSeries<PowerData, String>(
                dataSource: powerModel.powerConsumption?.asMap().entries.map((e) => PowerData(e.key, double.parse(e.value.toString()))).toList(),
                xValueMapper: (PowerData power, _) => powerModel.dates?[power.index],
                yValueMapper: (PowerData power, _) => power.value,
                color: Colors.tealAccent,
                markerSettings: MarkerSettings(isVisible: true,color: Colors.tealAccent),
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
              customWidget('Consumption in Kitchen (kW)',"${powerModel.consumpInKitchen} kW",Icons.house_rounded),
              SizedBox(height: 16),
              customWidget('Total AC Consumption (kW)',"${powerModel.acConsmp} kW",Icons.ac_unit_outlined),
              SizedBox(height: 16),
              customWidget('Total Consumption Amount (AED)',"${powerModel.totalAmount} AED",Icons.money), // Example text, replace with actual data
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
          color: Colors.yellow.shade100,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Row(
          children: [
            Icon(icon),
            Expanded(
              child: Column(
                children: [
                  Text(
                    heading,
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),
                  ),
                  SizedBox(height: 8),
                  Text(amount,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),
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
