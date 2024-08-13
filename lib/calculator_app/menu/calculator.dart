import 'dart:io';

import 'package:pdp_academy/calculator_app/model/colors.dart';
import '../data/calculator_data.dart';
import '../model/menu.dart';
import '../service/io_repository.dart';
import '../service/io_service.dart';

class CalculatorHomePage extends Menu {
  final IORepository _console = IOConsoleService();

  @override
  void build() {
    while (true) {
      _console.write("${"\n  Welcome to Calculator App  ".border.lightYellow}\n");

      _console.write("    Home menu     ".frame.border.cyan);
      _console.write("1. Calculator App ".frame.border.lightBlue);
      _console.write("2. History        ".frame.border.lightBlue);
      _console.write("${"0. Exit           ".frame.border.lightRed}\n");

      double? number = _console.readNum("Select your option: ") as double?;

      while (number == null || ![0, 1, 2].contains(number)) {
        _console.write(" ${"There is no such section.".lightRed.border}");
        number = _console.readNum("Select your option: ")! as double?;
        _console.write("");
      }

      switch (number) {
        case 1:
          _CalculatorApp().build();
        case 2:
          _CalculatorHistory().build();
        case 0:
          _console.write("Thank you for using our program.".border.lightYellow);
          exit(0);
      }
    }
  }
}

class _CalculatorApp extends Menu {
  final IORepository _console = IOConsoleService();
  final CalculatorArithmeticOperations _calculate = CalculatorArithmeticOperations();
  CalculatorData? _calculatorData;

  @override
  void build() {
    _console.write("\n-------------------------------------------------\n");
    _console.write("${" Calculator App ".frame.border.lightBlue}\n");

    double? numberOne = _console.readNum(
      "Enter your first number: ",
    ) as double?;

    while (numberOne == null) {
      _console.write("Please just enter a number.".lightRed.border);
      numberOne = _console.readNum("Enter you first number: ") as double?;
    }

    double? numberTwo = _console.readNum(
      "Enter your second number: ",
    ) as double?;

    while (numberTwo == null) {
      _console.write("Please just enter a number.".lightRed.border);
      numberTwo = _console.readNum("Enter you second number: ") as double?;
    }

    String? arithmeticOperations = _console.readString(
      "Enter your arithmetic operations(*, /, +, -): ",
    );

    if (!["+", "-", "/", "*"].contains(arithmeticOperations)) {
      while (arithmeticOperations != null) {
        _console.write("Please just enter a arithmetic operations.".lightRed.border);
        arithmeticOperations = _console.readString(
          "Enter your arithmetic operations(*, /, +, -): ",
        );
        if (["+", "-", "/", "*"].contains(arithmeticOperations)) break;
      }
    }

    double? result;

    switch (arithmeticOperations) {
      case "+":
        result = _calculate.addition(numberOne, numberTwo);
        break;
      case "-":
        result = _calculate.subtraction(numberOne, numberTwo);
        break;
      case "*":
        result = _calculate.multiplication(numberOne, numberTwo);
        break;
      case "/":
        result = _calculate.division(numberOne, numberTwo);
        break;
    }

    if (result != null) {
      int time = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      _calculatorData = CalculatorData(
        numberOne: numberOne,
        numberTwo: numberTwo,
        arithmeticOperations: arithmeticOperations!,
        result: result,
        time: time
      );

      FileService.postCalculatorData(
        FileService.calculatorHistoryPath,
        _calculatorData!,
      );
    }

    if (result != null) {
      _console.write(_calculatorData.toString());
    } else {
      _console.write("Cannot divide by zero".border.lightRed);
    }

    _console.write("\n-------------------------------------------------\n");
  }
}

class _CalculatorHistory extends Menu {
  final IORepository _console = IOConsoleService();
  List<CalculatorData>? _history;

  @override
  void build() {
    _console.write("\n-------------------------------------------------\n");

    _console.write(" History        ".frame.border.lightBlue);

    _history = FileService.getCalculatorData(
      FileService.calculatorHistoryPath,
    );

    if (_history != null) {
      for (int i = 0; i < _history!.length; i++) {
        DateTime time = DateTime.fromMillisecondsSinceEpoch(_history![i].time * 1000);

        _console.write("\n${i + 1}) Time: ${time.hour}:${time.minute}:${time.second}");
        _console.write("${_history![i]}");
      }
    } else {
      _console.write("\nThere is no history yet!\n".border.lightRed);
    }

    _console.write("\n-------------------------------------------------\n");
  }
}