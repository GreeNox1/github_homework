import 'dart:convert';
import 'dart:io' as io;

import 'package:pdp_academy/calculator_app/model/colors.dart';
import '../data/calculator_data.dart';

class FileService {
  static const String calculatorHistoryPath =
      "./assets/data/calculator_history_data.json";

  static List<CalculatorData>? getCalculatorData(String path) {
    try {
      io.File file = io.File(path);
      List<CalculatorData> calculatorDataList = calculatorDataFromJson(
        file.readAsStringSync(),
      );
      if (calculatorDataList.isNotEmpty) {
        return calculatorDataList;
      }
      return null;
    } catch (error) {
      return null;
    }
  }

  static String postCalculatorData(
    String path,
    CalculatorData calculatorData,
  ) {
    try {
      io.File file = io.File(path);
      List<CalculatorData> calculatorDataList = calculatorDataFromJson(
        file.readAsStringSync(),
      );
      calculatorDataList.add(calculatorData);
      file.writeAsStringSync(calculatorDataToJson(
        calculatorDataList,
      ));
      return calculatorData.toString();
    } catch (error) {
      print(error);
      return "Something went wrong!".lightRed.border;
    }
  }

  static String deleteCalculatorData(String path) {
    try {
      io.File file = io.File(path);
      file.absolute.writeAsStringSync(jsonEncode([]));
      return "The data has been successfully deleted.".border.lightGreen;
    } catch (error) {
      return "No data found".border.cyan;
    }
  }
}
