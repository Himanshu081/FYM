import 'package:fym_test_1/auth/src/auth_service_contract.dart';
import 'package:fym_test_1/auth/src/token.dart';
import 'package:async/async.dart';

class SignInUseCase {
  final IAuthService _authService;

  SignInUseCase(this._authService);

  Future<Result<Token>> execute() async {
    return await _authService.signin();
  }
}
