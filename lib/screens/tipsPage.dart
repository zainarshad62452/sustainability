import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TipsPage extends StatelessWidget {
  final double totalConsp;

  const TipsPage({Key? key, required this.totalConsp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> tips;
    Color tipsColor;

    // Determine tips based on energy consumption level
    if (totalConsp < 1000000) {
      tips = [
      ];
      tipsColor = Colors.green; // Example color for low consumption
    } else if (totalConsp >= 1000000 && totalConsp < 1500000) {
      tips = [
        "Turn off the AC when opening windows.",
        "Use electronics when necessary.",
        "Turn off the light when leaving classrooms/meetings room."
      ];
      tipsColor = Colors.orange; // Example color for medium consumption
    } else {
      tips = [
        "Turn off electronics that is not being used.",
        "Increase the temperature of AC by 1 degrees.",
        "Before leaving any room turn off the AC and lights."
      ];
      tipsColor = Colors.red; // Example color for high consumption
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Energy Consumption Tips'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(tipsColor!=Colors.green?
                'Tips to Reduce Energy Consumption':"Thank You For Saving The Energy",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: tipsColor,
                ),
              ),
              SizedBox(height: 20),
              Visibility(
                visible: tipsColor==Colors.green,
                  child: Column(
                children: [
                  Text("Keep The Good Work!",style: TextStyle(fontSize: 20),),
                  Lottie.asset("assets/thanks.json"),
                ],
              )),
              for (String tip in tips) ...[
                ListTile(
                  leading: Icon(Icons.lightbulb),
                  title: Text(tip),
                ),
                Divider(),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

