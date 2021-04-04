import 'package:flutter/foundation.dart';

class SignUpCredentail {
  final String name;
  final String email;
  final String password;
  final String college;
  final String department;

  SignUpCredentail(
      @required this.name,
      @required this.email,
      @required this.password,
      @required this.college,
      @required this.department);
}
