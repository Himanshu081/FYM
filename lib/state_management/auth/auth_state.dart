import 'package:equatable/equatable.dart';
import 'package:fym_test_1/auth/src/token.dart';

abstract class AuthState extends Equatable {}

class InitialState extends AuthState {
  @override
  List<Object> get props => [];
}

class LoadingState extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthSuccessState extends AuthState {
  final Token token;
  AuthSuccessState(this.token);

  @override
  List<Object> get props => [token];
}

class SignupSuccessState extends AuthState {
  final String result;

  SignupSuccessState(this.result);

  @override
  List<Object> get props => [result];
}

class ErrorState extends AuthState {
  final String message;
  ErrorState(this.message);
  @override
  List<Object> get props => [];
}

class SignOutSuccessState extends AuthState {
  @override
  List<Object> get props => [];
}
