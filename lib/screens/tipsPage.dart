import 'package:flutter/material.dart';

class TipsPage extends StatelessWidget {
  final double totalConsp;

  const TipsPage({Key? key, required this.totalConsp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> tips;
    Color tipsColor;

    // Determine tips based on energy consumption level
    if (totalConsp < 200000) {
      tips = [
        "Thank you for saving the energy!",
        "Keep up the good work.",
        "👍"
      ];
      tipsColor = Colors.green; // Example color for low consumption
    } else if (totalConsp >= 200000 && totalConsp < 350000) {
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
              Text(
                'Tips to Reduce Energy Consumption',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: tipsColor,
                ),
              ),
              SizedBox(height: 20),
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

