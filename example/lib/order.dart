
import 'package:annotations/annotations.dart';

@jsonGen
class Order {
  String name;
  String id;
  List<String> names;
  double amount;
  Order({
    required this.name,
    required this.id,
    required this.names,
    required this.amount,
  });
}
