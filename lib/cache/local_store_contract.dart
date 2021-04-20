import 'package:fym_test_1/auth/src/token.dart';
// import 'package:shared_preferences/shared_preferences.dart';

abstract class ILocalStore {
  Future<Token> fetch();
  Future<Email> fetchEmail();
  Future<UserName> fetchName();

  delete(Token token);
  deleteEmail(Email email);
  deleteName(UserName name);
  Future<void> save(Token token);
  // Future<AuthType> fetchAuthType();
  Future saveEmail(Email email);
  Future saveName(UserName name);
}
