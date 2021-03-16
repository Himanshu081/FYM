import 'package:fym_test_1/auth/src/token.dart';
import 'package:async/async.dart';

abstract class IAuthService {
  Future<Result<Token>> signin();
  Future<Result<bool>> signOut(Token token);
}
