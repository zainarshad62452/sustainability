import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:sustainability/Controllers/loading.dart';
import 'package:sustainability/models/powerModel.dart';
import 'package:sustainability/models/powerModelJson.dart';
import 'package:sustainability/screens/widgets/snackbar.dart';
import 'package:sustainability/services/csvServices.dart';
import 'package:sustainability/services/powerServices.dart';

class FilePickerPage extends StatefulWidget {
  @override
  _FilePickerPageState createState() => _FilePickerPageState();
}

class _FilePickerPageState extends State<FilePickerPage> {
  final PowerServices powerServices = PowerServices();
  final CsvServices csvServices = CsvServices();
  String? _fileName;
  String? csvData;
  String? jsonData;
  //
  // Future<void> _handleFilePick() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles();
  //
  //   if (result != null && result.files.isNotEmpty) {
  //     PlatformFile file = result.files.first;
  //     setState(() {
  //       _fileName = file.name;
  //     });
  //   }
  // }

  Future<void> _handleUpload() async {
      String filePath = await _getFilePath();
      // alertSnackbar(filePath);
      if (filePath.isNotEmpty) {
        String fileType = _fileName!.split('.').last.toLowerCase();
        if (fileType == "csv") {
          String csvString = await File(filePath).readAsString();
          String jsonString = csvServices.csvToJson(csvString);
          // alertSnackbar(jsonString);
          // csvData = jsonString;
          await _addPowerFromJson(jsonString);
        } else if (fileType == "xlsx") {
          String csvString = await csvServices.xlsxToCsv(filePath);
          // alertSnackbar(csvString+"             /////// Csv String");
          // csvData = csvString;
          String jsonString = csvServices.csvToJson(csvString);
          // alertSnackbar(jsonString);
          // jsonData = jsonString;
          await _addPowerFromJson(jsonString);
        } else {
          // Unsupported file format
          alertSnackbar("Please select a CSV or XLSX file.");
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Unsupported File Format"),
              content: Text("Please select a CSV or XLSX file."),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("OK"),
                ),
              ],
            ),
          );
        }
      }
  }

  Future<void> _addPowerFromJson(String jsonString) async {
    final firestore = FirebaseFirestore.instance;
    List<dynamic> jsonData = json.decode(jsonString);
    int i = 0;
    int year = 2013;
    for (dynamic data in jsonData) {
      // if(i==10){
      //   break;
      // }
      if(i != 0 || i != 40 ){
      if (data is Map<String, dynamic>) {
        i++;
        PowerModelJson powerModel = PowerModelJson.fromJson(data);
        powerModel.year = year.toString();
        powerModel.id = powerModel.buildings;
        try {
          String? id = powerModel.buildings==""?"No":powerModel.buildings;
          final powerCollection = firestore
              .collection("power_consumption")
              .doc(id??"No")
              .collection("power_consumption");

        //   final buildingDoc = firestore.collection("power_consumption").doc(id??"No");
        //   final buildingSnapshot = await buildingDoc.get();
        //   String the11 = powerModel.the11 == ""?"0":"${powerModel.the11}";
        // print(the11);
        //   double totalPowerConsp = double.parse(the11);
        //
        //   // If building exists, calculate average totalPowerConsp
        //   if (buildingSnapshot.exists) {
        //     final buildingData = buildingSnapshot.data() as Map<String, dynamic>;
        //     final existingTotalPowerConsp = double.parse(buildingData['totalPowerConsp'].toString()) ?? 0.0;
        //     final totalCount = (buildingData['powerCount'] ?? 0) + 1;
        //     totalPowerConsp = (existingTotalPowerConsp + double.parse(powerModel.the11.toString())) / totalCount;
        //
        //     // Update totalPowerConsp and increment powerCount in building document
        //     await buildingDoc.update({
        //       'totalPowerConsp': totalPowerConsp.toString(),
        //       'powerCount': totalCount,
        //     });
        //   } else {
        //     // Set totalPowerConsp and initialize powerCount in building document
        //     await buildingDoc.set({
        //       'id':id,
        //       'totalPowerConsp': totalPowerConsp,
        //       'powerCount': 1,
        //     });
        //   }

          // Add powerModel to power_consumption collection

          await powerCollection.doc(powerModel.year.toString()).set(powerModel.toJson()).then((value) => print(powerModel.toJson()));
        } catch (e) {
          print(e.toString());
        }
      }
      }else{
        if(i == 40){
          loading(false);
          i = 0;
          year++;
        }else{
          loading(true);
          i++;
        }
      }
    }
    snackbar("Done", "Power Added Successfully");
  }

  Future<String> _getFilePath() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.isNotEmpty) {
      PlatformFile file = result.files.first;
      return file.path ?? "";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("File Picker")),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed:  () async => await _handleUpload(),
                child: Text("Upload"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
