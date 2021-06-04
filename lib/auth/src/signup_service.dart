import 'package:fym_test_1/auth/src/token.dart';
import 'package:async/async.dart';

abstract class ISignupService {
  Future<String> signUp(String name, String email, String password,
      String college, String department);
}
