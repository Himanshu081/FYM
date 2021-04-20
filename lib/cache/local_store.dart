// import 'package:auth/auth.dart';
// import 'package:food_ordering_app/cache/local_store_contract.dart';
import 'package:fym_test_1/auth/src/token.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'local_store_contract.dart';

const CACHED_TOKEN = 'CACHED_TOKEN';
const CACHED_EMAIL = 'CACHED_EMAIL';
const CACHED_NAME = 'CACHED_NAME';

class LocalStore implements ILocalStore {
  final SharedPreferences sharedPreferences;

  LocalStore(this.sharedPreferences);

  @override
  delete(Token token) {
    sharedPreferences.remove(CACHED_TOKEN);
  }

  @override
  deleteName(UserName name) {
    sharedPreferences.remove(CACHED_NAME);
  }

  @override
  deleteEmail(Email email) {
    sharedPreferences.remove(CACHED_EMAIL);
  }

  @override
  Future<Token> fetch() {
    final tokenStr = sharedPreferences.getString(CACHED_TOKEN);
    if (tokenStr != null) return Future.value(Token(tokenStr));
    return null;
  }

  @override
  Future<Email> fetchEmail() {
    print("Fetch email called");
    final tokenStr = sharedPreferences.getString(CACHED_EMAIL);
    print("Fetched email is:" + tokenStr);

    if (tokenStr != null) return Future.value(Email(tokenStr));
    return null;
  }

  @override
  Future<UserName> fetchName() {
    final tokenStr = sharedPreferences.getString(CACHED_NAME);
    if (tokenStr != null) return Future.value(UserName(tokenStr));
    return null;
  }

  @override
  Future save(Token token) {
    print("token value inside local store.dart " + token.value);
    // sharedPreferences = SharedPreferences.getInstance();

    return sharedPreferences.setString(CACHED_TOKEN, token.value);
  }

  // @override
  // Future<AuthType> fetchAuthType() {
  //   final authType = sharedPreferences.getString(CACHED_AUTH);
  //   if (authType != null) {
  //     return Future.value(
  //         AuthType.values.firstWhere((val) => val.toString() == authType));
  //   }
  //   return null;
  // }

  @override
  Future saveEmail(Email email) {
    print("save email called,value of email received" + email.email);
    return sharedPreferences.setString(CACHED_EMAIL, email.email);
  }

  @override
  Future saveName(UserName name) {
    return sharedPreferences.setString(CACHED_NAME, name.name);
  }
}
