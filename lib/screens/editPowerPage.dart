import 'package:flutter/material.dart';
import 'package:sustainability/Controllers/loading.dart';
import 'package:sustainability/services/powerServices.dart';
import '../models/powerModel.dart';

class EditPowerPage extends StatefulWidget {
  final PowerModel powerModel;

  EditPowerPage({required this.powerModel});

  @override
  _EditPowerPageState createState() => _EditPowerPageState();
}

class _EditPowerPageState extends State<EditPowerPage> {
  final _formKey = GlobalKey<FormState>();
  late PowerModel _editedPowerModel;
  late TextEditingController _monthsController;
   List<TextEditingController> _powerConsumptionControllers=[];
  final _monthsInEnglish = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  @override
  void initState() {
    super.initState();
    _editedPowerModel = widget.powerModel;
    _monthsController = TextEditingController(text: _editedPowerModel.dates?.length.toString() ?? '');
    _generateMonthFields(_editedPowerModel.dates?.length ?? 0);
    _populateControllers();
  }

  @override
  void dispose() {
    _monthsController.dispose();
    _powerConsumptionControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Power Consumption'),
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
                  initialValue: _editedPowerModel.year,
                  decoration: InputDecoration(labelText: 'Year'),
                  onSaved: (value) => _editedPowerModel.year = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a year';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: _editedPowerModel.houseNo,
                  decoration: InputDecoration(labelText: 'House Number'),
                  onSaved: (value) => _editedPowerModel.houseNo = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a house number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: _editedPowerModel.totalPowerConsp,
                  decoration: InputDecoration(labelText: 'Total Power Consumption (kW)'),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _editedPowerModel.totalPowerConsp = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter total power consumption';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: _editedPowerModel.consumpInKitchen,
                  decoration: InputDecoration(labelText: 'Consumption in Kitchen (kW)'),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _editedPowerModel.consumpInKitchen = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter consumption in kitchen';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: _editedPowerModel.acConsmp,
                  decoration: InputDecoration(labelText: 'Total AC Consumption (kW)'),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _editedPowerModel.acConsmp = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter total AC consumption';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: _editedPowerModel.totalAmount,
                  decoration: InputDecoration(labelText: 'Total Amount'),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _editedPowerModel.totalAmount = value,
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
                    setState(() {

                    });
                    _generateMonthFields(int.tryParse(value) ?? 0);
                  },
                ),
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
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        _editedPowerModel.dates = _monthsInEnglish.take(int.tryParse(_monthsController.text) ?? 0).toList();
                        _editedPowerModel.powerConsumption = _powerConsumptionControllers.map((controller) => double.tryParse(controller.text) ?? 0).toList();
                        print(_editedPowerModel.toJson());
                        loading(true);
                        await PowerServices().updatePower(_editedPowerModel);
                      }
                    },
                    child: Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _generateMonthFields(int numberOfMonths) {
    _powerConsumptionControllers.clear();
    for (int i = 0; i < numberOfMonths; i++) {
      _powerConsumptionControllers.add(TextEditingController());
    }
    _populateControllers();
  }

  void _populateControllers() {
    _editedPowerModel.powerConsumption?.forEachIndexed((index, value) {
      _powerConsumptionControllers[index].text = value.toString();
    });
  }
}

extension IterableExtension<T> on Iterable<T> {
  void forEachIndexed(void Function(int index, T item) action) {
    int index = 0;
    for (T element in this) {
      action(index, element);
      index++;
    }
  }
}
