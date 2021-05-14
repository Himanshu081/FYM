import 'dart:convert';

import 'package:fym_test_1/auth/src/credentail.dart';
import 'package:fym_test_1/auth/src/signup_credential.dart';
import 'package:async/src/result/result.dart';
import 'package:fym_test_1/auth/src/token.dart';
import 'package:fym_test_1/cache/local_store.dart';
import 'package:fym_test_1/cache/local_store_contract.dart';
import 'package:fym_test_1/infra/api/auth_api_contract.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'Mapper.dart';

class AuthApi implements IAuthApi {
  final http.Client _client;
  String baseUrl;
  static SharedPreferences _sharedPreferences;
  static ILocalStore _localStore;

  AuthApi(this.baseUrl, this._client);

  @override
  Future<Result<String>> apisignIn(Credentail credentail) async {
    // print("Auth_api.dart called");
    // print(credentail.email + "" + credentail.password);
    // print(baseUrl);
    var endpoint = baseUrl + '/user/login';
    // print(endpoint);

    return await _postCredential(endpoint, credentail);
  }

  @override
  Future<Result<String>> signUp(SignUpCredentail credentail) async {
    var endpoint = baseUrl + '/user/signup';
    return await _signuppostCredential(endpoint, credentail);
  }

  Future<Result<String>> _postCredential(
      String endpoint, Credentail credentail) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    print("Post Credential called");
    // print(endpoint + "inside post credential");
    // print(credentail.email + " inside post credential " + credentail.password);
    // var response = await http.post(endpoint,
    //     body: jsonEncode(Mapper.toJson(credentail)), headers: headers);
    final body = jsonEncode(
        {"email": credentail.email, "password": credentail.password});
    // print(body);
    var response = await _client.post(endpoint, body: body, headers: headers);
    // print(response.body);
    // print(response.toString());
    if (response.statusCode != 200) {
      // print("Something wemt wrong");
      Map map = jsonDecode(response.body);
      return Result.error(_transformError(map));
    }
    // print("We GOT something");
    var json = jsonDecode(response.body);
    _sharedPreferences = await SharedPreferences.getInstance();
    _localStore = LocalStore(_sharedPreferences);
    final email = Email(credentail.email);
    print("user email is: " + email.email);
    _localStore.saveEmail(email);
    print("saved user email");

    final username = UserName(json['data']['name']);

    print("Usrname fetched is :: " + json['data']['name'].toString());
    _localStore.saveName(username);
    print("saved user name");

    // print("value of token fetched in auth api .dart::" + json['token']);
    return json['token'] != null
        ? Result.value(json['token'])
        : Result.value(json['msg']);
  }

  Future<Result<String>> _signuppostCredential(
      String endpoint, SignUpCredentail credentail) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "name": credentail.name,
      "email": credentail.email,
      "password": credentail.password,
      "college": credentail.college,
      "department": credentail.department
    });
    var response = await http.post(
      endpoint,
      headers: headers,
      body: body,
    );
    if (response.statusCode != 200) return Result.error("Server Error");
    var json = jsonDecode(response.body);

    return json['token'] != null
        ? Result.value(json['token'])
        : Result.value(json['msg']);
  }

  @override
  Future<Result<bool>> signOut(Token token) async {
    var url = baseUrl + 'user/signout';
    var headers = {
      "Content-type": "application/json",
      "Authorization": token.value
    };
    var response = await _client.post(url, headers: headers);
    if (response.statusCode != 200) return Result.value(false);
    return Result.value(true);
  }

  _transformError(Map map) {
    var contents = map['msg'];
    // print("error message received is : " + contents);
    if (contents is String) return contents;
    var errStr =
        contents.fold('', (prev, ele) => prev + ele.values.first + '\n');
    return errStr.trim();
  }
}
