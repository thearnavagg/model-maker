
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';

class ModelVisitor extends SimpleElementVisitor<void> {
  String className = '';
  Map<String, String> fields = {};

  @override
  void visitConstructorElement(ConstructorElement element) {
    final returnType = element.returnType.toString();
    className = returnType.replaceFirst(
        '*', '');
  }

  @override
  void visitFieldElement(FieldElement element) {
    final fieldName = element.name;
    final fieldType = element.type
        .toString()
        .replaceFirst('*', '');
    fields[fieldName] = fieldType;
  }
}
