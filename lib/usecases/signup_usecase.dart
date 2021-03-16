import 'package:fym_test_1/auth/src/signup_service.dart';
import 'package:fym_test_1/auth/src/token.dart';
import 'package:async/async.dart';

class SignUpUseCase {
  final ISignupService _signUpService;

  SignUpUseCase(this._signUpService);

  Future<Result<Token>> execute(String name, String email, String password,
      String college, String department) async {
    return await _signUpService.signUp(
        name, email, password, college, department);
  }
}
