import 'package:fym_test_1/auth/src/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ILocalStore {
  Future<Token> fetch();
  delete(Token token);
  Future<void> save(Token token);
  // Future<AuthType> fetchAuthType();
  // Future saveAuthType(AuthType type);
}
