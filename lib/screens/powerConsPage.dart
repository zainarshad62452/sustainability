import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:sustainability/models/powerModel.dart';
import 'package:sustainability/screens/editPowerPage.dart';
import 'package:sustainability/screens/tipsPage.dart';
import 'package:sustainability/services/powerServices.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PowerConsumptionPage extends StatefulWidget {
  PowerModel powerModel;
  bool isAdmin;
  String totalPowerConsp;
  double averagePowerConsp;
  Color color;

  PowerConsumptionPage({
    required this.powerModel,
    required this.isAdmin,
    required this.color,
    required this.totalPowerConsp,
    required this.averagePowerConsp,

  });

  @override
  _PowerConsumptionPageState createState() => _PowerConsumptionPageState();
}

class _PowerConsumptionPageState extends State<PowerConsumptionPage> {
  String selectedDuration = '12 Months'; // Initial selected duration

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Dropdown menu for selecting duration
        DropdownButton<String>(
          value: selectedDuration,
          onChanged: (String? newValue) {
            setState(() {
              selectedDuration = newValue!;
            });
          },
          items: <String>['3 Months', '6 Months', '12 Months']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        Visibility(
          visible:
          FirebaseAuth.instance.currentUser?.email == "admin@sustainability.com",
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    Get.to(EditPowerPage(powerModel: widget.powerModel));
                  },
                  icon: Icon(Icons.edit)),
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            title: Text("Deleting The Power Consumption Record"),
                            content: Text("Do you want to delete this record?"),
                            actions: [
                              ElevatedButton(
                                  onPressed: () =>
                                      PowerServices().deletePower(widget.powerModel),
                                  child: Text("Yes")),
                              TextButton(
                                  onPressed: () => Get.back(), child: Text("No")),
                            ],
                          );
                        });
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  )),
            ],
          ),
        ),
        GestureDetector(
          onTap: () => Get.to(() => TipsPage(
              totalConsp: widget.averagePowerConsp)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.lightbulb_circle_outlined,
                      color: widget.averagePowerConsp < 1000000
                          ? Colors.green.shade800
                          : widget.averagePowerConsp < 1500000
                          ? Colors.yellow
                          : Colors.red,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      "Tips",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Text(
          widget.powerModel.houseNo.toString(),
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            color: widget.averagePowerConsp < 1000000
                ? Colors.green.shade800
                : widget.averagePowerConsp < 1500000
                ? Colors.yellow
                : Colors.red,),
        ),
        Container(
          height: 300,
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            series: <CartesianSeries>[
              LineSeries<PowerData, String>(
                dataSource: getFilteredData(),
                xValueMapper: (PowerData power, _) => widget.powerModel.dates?[power.index],
                yValueMapper: (PowerData power, _) => power.value,
                color: widget.color,
                markerSettings: MarkerSettings(isVisible: true, color: widget.color),
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
              customWidget(
                  'Total Power Consumption (kW)', "${widget.powerModel.totalPowerConsp} kW", Icons.show_chart),
              SizedBox(height: 16),
              customWidget(
                  'Carbon FootPrints (tCO2e)',
                  "${((double.parse(widget.powerModel.totalPowerConsp.toString()) * 0.21233) / 1000)} tCO2e",
                  Icons.energy_savings_leaf_outlined),
              SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }

  List<PowerData> getFilteredData() {
    List<PowerData> filteredData = [];
    int months = 3;
    if (selectedDuration == '6 Months') {
      months = 6;
    } else if (selectedDuration == '12 Months') {
      months = 12;
    }

    // Your logic to filter the data based on the selected duration
    // For example, you might want to display the last 'months' data points
    // You can adjust this logic based on your requirements
    int startIndex = widget.powerModel.powerConsumption!.length - months;
    if (startIndex < 0) startIndex = 0;
    for (int i = startIndex; i < widget.powerModel.powerConsumption!.length; i++) {
      filteredData.add(PowerData(i, double.parse(widget.powerModel.powerConsumption![i].toString())));
    }
    return filteredData;
  }

  Padding customWidget(String heading, String amount, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: widget.color == Colors.yellow ? Colors.black : Colors.white,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    heading,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: widget.color == Colors.yellow ? Colors.black : Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    amount,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: widget.color == Colors.yellow ? Colors.black : Colors.white),
                  ),
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
