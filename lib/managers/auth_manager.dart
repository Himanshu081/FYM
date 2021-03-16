// import 'package:auth/auth.dart';
// import 'package:auth/src/credential.dart';
// import 'package:auth/src/infra/adapters/email_auth.dart';
// import 'package:auth/src/infra/adapters/google_auth.dart';
// import 'package:auth/src/infra/api/auth_api_contract.dart';
import 'package:fym_test_1/auth/src/credentail.dart';
import 'package:fym_test_1/auth/src/auth_service_contract.dart';

import 'package:fym_test_1/auth/src/signup_service.dart';
import 'package:fym_test_1/infra/api/auth_api_contract.dart';
import 'package:fym_test_1/infra/email_auth.dart';

class AuthManager {
  IAuthApi _api;
  AuthManager(IAuthApi api) {
    this._api = api;
  }
  IAuthService emailAuth(String type) {
    print("inside auth manager");
    var service;
    switch (type) {
      case "email":
        service = EmailAuth(_api);
        // print(service.credential.email + " " + service.credential.password);
        break;
    }
    return service;
    // print("email AUTH OF AUTH MANAGER CALLED!!");
    // print(email + "  " + password);
    // final emailAuth = EmailAuth(_api);
    // emailAuth.credential(email, password);
    // return emailAuth;
  }
  // IAuthService emailservice({}) {

  //   // switch (type) {
  //   //   case AuthType.google:
  //   //     service = GoogleAuth(_api);
  //   //     break;
  //   //   case AuthType.email:
  //   //     service = EmailAuth(_api);
  //   //     break;
  //   // }
  //   return service;
  // }
}
