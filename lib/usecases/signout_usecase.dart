import 'package:fym_test_1/auth/src/auth_service_contract.dart';

import 'package:fym_test_1/auth/src/token.dart';
import 'package:async/async.dart';

class SignOutUseCase {
  final IAuthService _authService;

  SignOutUseCase(this._authService);

  Future<Result<bool>> execute(Token token) async {
    return await _authService.signOut(token);
  }
}
