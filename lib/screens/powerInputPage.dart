// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sustainability/Controllers/loading.dart';
// import 'package:sustainability/screens/widgets/loading.dart';
// import 'package:sustainability/services/powerServices.dart';
// import '../models/powerModel.dart';
//
// class PowerInputPage extends StatefulWidget {
//   @override
//   _PowerInputPageState createState() => _PowerInputPageState();
// }
//
// class _PowerInputPageState extends State<PowerInputPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _powerModel = PowerModel();
//   final _monthsController = TextEditingController();
//   final _powerConsumptionControllers = <TextEditingController>[];
//   final _monthsInEnglish = [
//     'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
//   ];
//
//   @override
//   void dispose() {
//     _monthsController.dispose();
//     _powerConsumptionControllers.forEach((controller) => controller.dispose());
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() => Stack(
//       children: [
//         Scaffold(
//           appBar: AppBar(
//             title: Text('Add Power Consumption'),
//           ),
//           body: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     TextFormField(
//                       decoration: InputDecoration(labelText: 'Year'),
//                       onSaved: (value) => _powerModel.year = value,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter a year';
//                         }
//                         return null;
//                       },
//                     ),
//                     TextFormField(
//                       decoration: InputDecoration(labelText: 'House Number'),
//                       onSaved: (value) => _powerModel.houseNo = value,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter a house number';
//                         }
//                         return null;
//                       },
//                     ),
//                     TextFormField(
//                       decoration: InputDecoration(labelText: 'Total Power Consumption (kW)'),
//                       keyboardType: TextInputType.number,
//                       onSaved: (value) => _powerModel.totalPowerConsp = value,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter total power consumption';
//                         }
//                         return null;
//                       },
//                     ),

//                     TextFormField(
//                       controller: _monthsController,
//                       decoration: InputDecoration(labelText: 'Number of Months'),
//                       keyboardType: TextInputType.number,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter number of months';
//                         }
//                         return null;
//                       },
//                       onChanged: (value) {
//                         setState(() {
//
//                         });
//                         _generateMonthFields(int.tryParse(value) ?? 0);
//                       },
//                     ),
//                     SizedBox(height: 16),
//                     ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: _powerConsumptionControllers.length,
//                       itemBuilder: (context, index) {
//                         return Row(
//                           children: [
//                             Expanded(
//                               child: TextFormField(
//                                 controller: _powerConsumptionControllers[index],
//                                 decoration: InputDecoration(labelText: 'Power Consumption for ${_monthsInEnglish[index]} (kW)'),
//                                 keyboardType: TextInputType.number,
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return 'Please enter power consumption';
//                                   }
//                                   return null;
//                                 },
//                               ),
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                     SizedBox(height: 16),
//                     Center(
//                       child: ElevatedButton(
//                         onPressed: () async {
//                             print("Doing");
//                           if (_formKey.currentState!.validate()) {
//                             loading(true);
//                             _formKey.currentState!.save();
//                             _powerModel.dates = _monthsInEnglish.take(int.tryParse(_monthsController.text) ?? 0).toList();
//                             _powerModel.powerConsumption = _powerConsumptionControllers.map((controller) => double.tryParse(controller.text) ?? 0).toList();
//                             print(_powerModel.toJson());
//                             await PowerServices().addPower(powerModel: _powerModel);
//
//                           }
//                         },
//                         child: Text('Save'),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//         !loading()?SizedBox():LoadingWidget()
//       ],
//     ));
//   }
//
//   void _generateMonthFields(int numberOfMonths) {
//     _powerConsumptionControllers.clear();
//     for (int i = 0; i < numberOfMonths; i++) {
//       _powerConsumptionControllers.add(TextEditingController());
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sustainability/Controllers/loading.dart';
import 'package:sustainability/screens/widgets/loading.dart';
import 'package:sustainability/services/powerServices.dart';
import '../models/powerModel.dart';

class PowerInputPage extends StatefulWidget {
  @override
  _PowerInputPageState createState() => _PowerInputPageState();
}

class _PowerInputPageState extends State<PowerInputPage> {
  final _formKey = GlobalKey<FormState>();
  final _powerModel = PowerModel();
  final _monthsController = TextEditingController();
  final _powerConsumptionControllers = <TextEditingController>[];
  final _monthsInEnglish = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  RxDouble totalPowerConsumption = 0.0.obs;

  @override
  void dispose() {
    _monthsController.dispose();
    _powerConsumptionControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text('Add Power Consumption'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Year'),
                      onSaved: (value) => _powerModel.year = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a year';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'House Number'),
                      onSaved: (value) => _powerModel.houseNo = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a house number';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Consumption in Kitchen (kW)'),
                      keyboardType: TextInputType.number,
                      onSaved: (value) => _powerModel.consumpInKitchen = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter consumption in kitchen';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Total AC Consumption (kW)'),
                      keyboardType: TextInputType.number,
                      onSaved: (value) => _powerModel.acConsmp = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter total AC consumption';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Total Amount'),
                      keyboardType: TextInputType.number,
                      onSaved: (value) => _powerModel.totalAmount = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter total amount';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _monthsController,
                      decoration: InputDecoration(labelText: 'Number of Months'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter number of months';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {});
                        _generateMonthFields(int.tryParse(value) ?? 0);
                      },
                    ),
                    // Other form fields...
                    SizedBox(height: 16),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _powerConsumptionControllers.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _powerConsumptionControllers[index],
                                decoration: InputDecoration(labelText: 'Power Consumption for ${_monthsInEnglish[index]} (kW)'),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter power consumption';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _updateTotalPowerConsumption();
                                  });
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          print("Doing");
                          if (_formKey.currentState!.validate()) {
                            loading(true);
                            _formKey.currentState!.save();
                            _powerModel.dates = _monthsInEnglish.take(int.tryParse(_monthsController.text) ?? 0).toList();
                            _powerModel.powerConsumption = _powerConsumptionControllers.map((controller) => double.tryParse(controller.text) ?? 0).toList();
                            _powerModel.totalPowerConsp = totalPowerConsumption.value.toString();
                            print(_powerModel.toJson());
                            await PowerServices().addPower(powerModel: _powerModel);
                          }
                        },
                        child: Text('Save'),
                      ),
                    ),
                    SizedBox(height: 16),
                    Obx(() => Text(
                      'Total Power Consumption: ${totalPowerConsumption.value} kW',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )),
                  ],
                ),
              ),
            ),
          ),
        ),
        !loading()?SizedBox():LoadingWidget()
      ],
    ));
  }

  void _generateMonthFields(int numberOfMonths) {
    _powerConsumptionControllers.clear();
    for (int i = 0; i < numberOfMonths; i++) {
      _powerConsumptionControllers.add(TextEditingController());
    }
  }

  void _updateTotalPowerConsumption() {
    double total = 0.0;
    for (TextEditingController controller in _powerConsumptionControllers) {
      double value = double.tryParse(controller.text) ?? 0.0;
      total += value;
    }
    totalPowerConsumption.value = total;
  }
}
