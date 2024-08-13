import 'dart:io';

abstract class IORepository {
  String? readString(String str);

  num? readNum(String str);

  void write(String str);
}

class IOConsoleService implements IORepository {
  @override
  String? readString(String str) {
    stdout.write(str);
    return stdin.readLineSync();
  }

  @override
  void write(String str) {
    print(str);
  }

  @override
  num? readNum(String str) {
    stdout.write(str);
    if (num == int) {
      return int.tryParse(stdin.readLineSync()!);
    }
    return double.tryParse(stdin.readLineSync()!);
  }
}
