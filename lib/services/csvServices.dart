import 'dart:convert';
import 'dart:io';
import 'package:excel/excel.dart';
import 'package:csv/csv.dart';

class CsvServices {
  Future<String> xlsxToCsv(String xlsxFilePath) async {
    var bytes = await File(xlsxFilePath).readAsBytes();
    var excel = Excel.decodeBytes(bytes);
    var table = excel.tables[excel.tables.keys.first];

    List<List<dynamic>> csvData = [];
    table?.
    rows.forEach((row) {
      csvData.add(row.map((cell) => cell?.value).toList());
    });

    // Convert to CSV format
    String csvString = ListToCsvConverter().convert(csvData);
    return csvString;
  }

  String csvToJson(String csvString) {
    List<List<dynamic>> csvData = CsvToListConverter().convert(csvString);

    if (csvData.isNotEmpty) {
      List<Map<String, dynamic>> jsonData = [];
      List<String> headers = csvData[0].map((cell) => cell.toString()).toList();

      for (int i = 1; i < csvData.length; i++) {
        Map<String, dynamic> row = {};
        for (int j = 0; j < headers.length; j++) {
          row[headers[j]] = csvData[i][j];
        }
        jsonData.add(row);
      }

      return json.encode(jsonData);
    } else {
      return '[]'; // Return empty array if CSV data is empty
    }
  }
}
