import 'package:cubit/cubit.dart';
import 'package:fym_test_1/auth/src/auth_service_contract.dart';
import 'package:fym_test_1/auth/src/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_state.dart';
import 'package:async/async.dart';
import 'package:fym_test_1/cache/local_store_contract.dart';
import 'package:fym_test_1/auth/src/signup_service.dart';
import 'package:fym_test_1/models/User.dart';

class AuthCubit extends Cubit<AuthState> {
  final ILocalStore localStore;
  AuthCubit(this.localStore) : super(InitialState());

  signin(IAuthService authService) async {
    // print("service passed in auth cubit is :" + authService.toString());
    // print("Inside Auth Cubit !!!");
    _startLoading();

    final result = await authService.signin();
    // localStore.saveAuthType(type);
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // print(
    //     "token received from api response result" + result.asValue.toString());

    _setResultOfAuthState(result);
  }

  Future<String> getDetails() async {
    final username = await localStore.fetchName();
    final email = await localStore.fetchEmail();
    final String mystring = username.name + "+" + email.email;
    return mystring;
  }

  Future<UserName> getUsername() async {
    final username = await localStore.fetchName();
    return username;
  }

  Future<Email> getEmail() async {
    final email = await localStore.fetchEmail();
    return email;
  }

  signout(IAuthService authService) async {
    _startLoading();
    final token = await localStore.fetch();
    final result = await authService.signOut(token);
    if (result.asValue.value) {
      //  print("Set Result of Auth State called");
      localStore.delete(token);
      emit(SignOutSuccessState());
    } else {
      emit(ErrorState('Error signing out'));
    }
  }

  signup(ISignupService signUpService, User user) async {
    _startLoading();
    final result = await signUpService.signUp(
        user.name, user.email, user.password, user.college, user.department);
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _setResultOfAuthState(result);
  }

  void _setResultOfAuthState(Result<Token> result) {
    // print("Set Result of Auth State called");
    if (result.asError != null) {
      // print("Error state called");
      emit(ErrorState(result.asError.error));
    } else {
      // print("going to localstore.dart to store token");

      localStore.save(result.asValue.value);

      // print("TOken saved success state called");
      emit(AuthSuccessState(result.asValue.value));
    }
  }

  void _startLoading() {
    print("Loading state called !!");
    emit(LoadingState());
  }
}
