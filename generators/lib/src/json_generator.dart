
import 'package:analyzer/dart/element/element.dart';
import 'package:annotations/annotations.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:generators/src/model_visitor.dart';
import 'package:source_gen/source_gen.dart';

class JsonGenerator extends GeneratorForAnnotation<JSONGenAnnotation> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final visitor = ModelVisitor();
    element.visitChildren(visitor);

    final buffer = StringBuffer();
    final className = '${visitor.className}Gen';

    // Generate class definition
    buffer.writeln('class $className {');

    // Generate fields
    for (int i = 0; i < visitor.fields.length; i++) {
      buffer.writeln(
        'final ${visitor.fields.values.elementAt(i)} ${visitor.fields.keys.elementAt(i)};',
      );
    }

    // Generate constructor
    buffer.writeln('const $className({');
    for (int i = 0; i < visitor.fields.length; i++) {
      buffer.writeln(
        'required this.${visitor.fields.keys.elementAt(i)},',
      );
    }
    buffer.writeln('});');

    // Generate toMap method
    buffer.writeln('Map<String, dynamic> toMap() {');
    buffer.writeln('return {');
    for (int i = 0; i < visitor.fields.length; i++) {
      buffer.writeln(
        "'${visitor.fields.keys.elementAt(i)}': ${visitor.fields.keys.elementAt(i)},",
      );
    }
    buffer.writeln('};');
    buffer.writeln('}');

    // Generate fromMap factory
    buffer.writeln('factory $className.fromMap(Map<String, dynamic> map) {');
    buffer.writeln('return $className(');
    for (int i = 0; i < visitor.fields.length; i++) {
      buffer.writeln(
        "${visitor.fields.keys.elementAt(i)}: map['${visitor.fields.keys.elementAt(i)}'],",
      );
    }
    buffer.writeln(');');
    buffer.writeln('}');

    // Generate copyWith method
    buffer.writeln('$className copyWith({');
    for (int i = 0; i < visitor.fields.length; i++) {
      buffer.writeln(
        '${visitor.fields.values.elementAt(i)}? ${visitor.fields.keys.elementAt(i)},',
      );
    }
    buffer.writeln('}) {');
    buffer.writeln('return $className(');
    for (int i = 0; i < visitor.fields.length; i++) {
      buffer.writeln(
        "${visitor.fields.keys.elementAt(i)}: ${visitor.fields.keys.elementAt(i)} ?? this.${visitor.fields.keys.elementAt(i)},",
      );
    }
    buffer.writeln(');');
    buffer.writeln('}');
    buffer.writeln('}');

    return buffer.toString();
  }
}
