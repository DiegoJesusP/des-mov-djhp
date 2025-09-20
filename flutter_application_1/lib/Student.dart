import 'package:flutter_application_1/person.dart';

class Student extends Person{
  String studentId;

  Student( String name, this.studentId) : super(name);
}