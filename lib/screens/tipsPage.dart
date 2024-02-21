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
        "Use energy-efficient LED light bulbs throughout your home.",
        "Unplug electronics when not in use to reduce phantom power consumption.",
        "Set your thermostat to a lower temperature in the winter and higher temperature in the summer."
      ];
      tipsColor = Colors.green; // Example color for low consumption
    } else if (totalConsp >= 200000 && totalConsp < 350000) {
      tips = [
        "Upgrade to energy-efficient appliances with ENERGY STAR ratings.",
        "Install a programmable thermostat to optimize heating and cooling schedules.",
        "Seal air leaks around windows, doors, and ducts to improve energy efficiency."
      ];
      tipsColor = Colors.orange; // Example color for medium consumption
    } else {
      tips = [
        "Invest in renewable energy sources like solar panels or wind turbines.",
        "Schedule regular maintenance for HVAC systems to ensure optimal performance.",
        "Consider installing smart home devices to monitor and control energy usage remotely."
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

