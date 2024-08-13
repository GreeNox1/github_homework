void main() {
  print("Create new branch. This name is greenox");
}

class User {

  final String name;
  final int age;

  User({required this.name, required this.age});

  @override
  String toString() {
    return "Name: $name, Age: $age";
  }
}