import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:fym_test_1/auth/src/auth_service_contract.dart';
import 'package:fym_test_1/auth/src/credentail.dart';
import 'package:fym_test_1/auth/src/signup_credential.dart';
import 'package:fym_test_1/auth/src/signup_service.dart';
import 'package:fym_test_1/auth/src/token.dart';

import 'api/auth_api.dart';
import 'api/auth_api_contract.dart';

class EmailAuth implements IAuthService {
  AuthApi sut; //api endpoint
  Credentail _credentail;

  EmailAuth(this.sut);
  void credential(@required String email, @required String password) {
    _credentail = Credentail(email, password);
    print("the credentials in EMial auth is" + _credentail.toString());
  }

  @override
  Future<Result<Token>> signin() async {
    // print(_credentail);
    // assert(_credentail != null);
    print("Inside signin of Email Auth implemnts iauth");

    // print(_credentail.email + "  " + _credentail.password);
    // var credential = Credentail(_credentail.email, _credentail.password);
    print(_credentail);
    print("auth api instance " + sut.toString());
    // print(_api.apisignIn(_credentail));
    var result = await sut.apisignIn(_credentail);
    print(result);
    if (result.isError) return result.asError;
    return Result.value(Token(result.asValue.value));
  }

  @override
  Future<Result<bool>> signOut(Token token) async {
    return await sut.signOut(token);
  }

  // @override
  // Future<Result<Token>> signUp(String name, String email, String password,
  //     String college, String department) async {
  //   SignUpCredentail _credentail =
  //       SignUpCredentail(name, email, password, college, department);
  //   var result = await _api.signUp(_credentail);
  //   if (result.isError) return result.asError;
  //   return Result.value(Token(result.asValue.value));
  // }
}
