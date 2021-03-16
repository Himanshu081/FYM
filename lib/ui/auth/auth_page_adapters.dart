import 'package:flutter/material.dart';
import 'package:fym_test_1/auth/src/auth_service_contract.dart';

abstract class IAuthPageAdapter {
  void onAuthSuccess(BuildContext context, IAuthService authService);
}

class AuthPageAdapter implements IAuthPageAdapter {
  final Widget Function(IAuthService authService) onUserAuthenticated;

  AuthPageAdapter({
    @required this.onUserAuthenticated,
  });

  @override
  void onAuthSuccess(BuildContext context, IAuthService authService) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => onUserAuthenticated(authService),
        ),
        (Route<dynamic> route) => false);
  }
}
