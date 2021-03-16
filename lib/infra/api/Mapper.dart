import 'package:fym_test_1/auth/src/credentail.dart';

class Mapper {
  static Map<String, dynamic> toJson(Credentail credentail) =>
      {"email": credentail.email, "password": credentail.password};
}
