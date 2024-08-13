import 'dart:convert';

import 'package:pdp_academy/calculator_app/model/colors.dart';


List<CalculatorData> calculatorDataFromJson(String data) =>
    List<CalculatorData>.from(jsonDecode(data).map(
      (e) => CalculatorData.fromJson(e),
    ));

String calculatorDataToJson(List<CalculatorData> calculatorData) =>
    jsonEncode(calculatorData);

class CalculatorData {
  double numberOne;
  double numberTwo;
  double? result;
  String arithmeticOperations;
  int time;

  CalculatorData({
    required this.numberOne,
    required this.numberTwo,
    required this.arithmeticOperations,
    required this.result,
    required this.time
  });

  factory CalculatorData.fromJson(Map<String, Object?> json) => CalculatorData(
        numberOne: json["numberOne"] as double,
        numberTwo: json["numberTwo"] as double,
        arithmeticOperations: json["arithmeticOperations"] as String,
        result: json["result"] as double,
        time: json["time"] as int
      );

  Map<String, Object?> toJson() => {
        "numberOne": numberOne,
        "numberTwo": numberTwo,
        "arithmeticOperations": arithmeticOperations,
        "result": result,
        "time": time
      };

  @override
  int get hashCode =>
      Object.hash(numberOne, numberTwo, result, arithmeticOperations, time,);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalculatorData &&
          runtimeType == other.runtimeType &&
          numberOne == other.numberOne &&
          numberTwo == other.numberTwo &&
          arithmeticOperations == other.arithmeticOperations &&
          result == other.result &&
          time == other.time;

  @override
  String toString() {
    return "$numberOne $arithmeticOperations $numberTwo = $result\n"
        .border
        .cyan;
  }
}

class CalculatorArithmeticOperations {
  double addition(double numberOne, double numberTwo) {
    return numberOne + numberTwo;
  }

  double subtraction(double numberOne, double numberTwo) {
    return numberOne - numberTwo;
  }

  double multiplication(double numberOne, double numberTwo) {
    return numberOne * numberTwo;
  }

  double? division(double numberOne, double numberTwo) {
    if (numberTwo == 0) {
      return null;
    }
    return numberOne / numberTwo;
  }
}
