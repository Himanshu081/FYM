import 'package:async/async.dart';
import 'package:fym_test_1/auth/src/signup_service.dart';
import 'package:fym_test_1/auth/src/token.dart';

// import 'package:auth/src/infra/api/auth_api_contract.dart';
import 'package:fym_test_1/infra/api/auth_api_contract.dart';
import 'package:fym_test_1/auth/src/signup_credential.dart';

// import '../../domain/credential.dart';

class SignUpService implements ISignupService {
  final IAuthApi _api;

  SignUpService(this._api);

  @override
  Future<Result<Token>> signUp(
    String name,
    String email,
    String password,
    String college,
    String department,
  ) async {
    SignUpCredentail credential =
        SignUpCredentail(name, email, password, college, department);

    var result = await _api.signUp(credential);
    if (result.isError) return result.asError;
    return Result.value(Token(result.asValue.value));
  }
}
