import 'package:flutter/foundation.dart';

class User {
  String name;
  String email;
  String password;
  String college;
  String department;

  User({
    @required this.name,
    @required this.email,
    @required this.password,
    @required this.college,
    @required this.department,
  });
}
