import 'package:fym_test_1/auth/src/credentail.dart';
import 'package:async/async.dart';
import 'package:fym_test_1/auth/src/signup_credential.dart';
import 'package:fym_test_1/auth/src/token.dart';

abstract class IAuthApi {
  Future<Result<String>> apisignIn(Credentail credentail);
  Future<String> signUp(SignUpCredentail credentail);
  Future<Result<bool>> signOut(Token token);
}
