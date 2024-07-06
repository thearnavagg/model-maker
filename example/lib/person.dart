import 'package:annotations/annotations.dart';


@jsonGen
class Person {
  String name;
  String lastName;
  bool isAdult;
  int age;
  Person({
    required this.name,
    required this.lastName,
    required this.isAdult,
    required this.age,
  });
}
