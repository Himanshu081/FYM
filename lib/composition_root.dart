// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:fym_test_1/auth/src/auth_service_contract.dart';
import 'package:fym_test_1/cache/local_store.dart';
import 'package:fym_test_1/infra/api/auth_api_contract.dart';
import 'package:fym_test_1/infra/signup_service.dart';
import 'package:fym_test_1/managers/auth_manager.dart';
import 'package:fym_test_1/state_management/auth/auth_cubit.dart';
import 'package:fym_test_1/ui/auth/auth_page.dart';
import 'package:fym_test_1/ui/auth/auth_page_adapters.dart';
import 'package:fym_test_1/ui/auth/splashscreen.dart';
import 'package:fym_test_1/ui/homepage/homepage.dart';
import 'infra/api/auth_api_contract.dart';
import 'infra/api/auth_api.dart';
import 'auth/src/signup_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cache/local_store_contract.dart';
import 'package:http/http.dart' as http;

class CompositionRoot {
  static SharedPreferences _sharedPreferences;
  static ILocalStore _localStore;
  static IAuthApi _authApi;
  static String _baseUrl;
  static http.Client _client;
  static AuthManager manager;
  static AuthApi sut;

  static configure() {
    // _sharedPreferences = await SharedPreferences.getInstance();
    _localStore = LocalStore(_sharedPreferences);

    _client = http.Client();
    _baseUrl = "http://192.168.0.7:5000";
    print("heloo from " + _baseUrl);
    manager = AuthManager(_authApi);
    sut = AuthApi(_baseUrl, _client);
  }

  static Widget composeAuthUi() {
    // print(_baseUrl);
    IAuthApi _api = AuthApi(_baseUrl, _client);
    AuthCubit _authCubit = AuthCubit(_localStore);
    ISignupService _signupService = SignUpService(_api);
    // AuthManager manager = AuthManager(_authApi);
    IAuthPageAdapter _adapter =
        AuthPageAdapter(onUserAuthenticated: composeHomeUi);
    // IAuthService _authservice = AuthApi(baseUrl, _client)

    return CubitProvider(
        create: (BuildContext context) => _authCubit,
        child: OnboardingScreen(_signupService, manager, _adapter, sut));
  }

  static Widget composeHomeUi(IAuthService service) {
    // RestaurantCubit _restaurantCubit =
    //     RestaurantCubit(_api, defaultPageSize: 20);
    // IHomePageAdapter adapter = HomePageAdapter(
    //     onSearch: _composeSearchResultsPageWith,
    //     onSelection: _composeRestaurantPageWith,
    //     onLogout: composeAuthUi);
    AuthCubit _authCubit = AuthCubit(_localStore);

    return Scaffold(
      body: HomePage(),
    );

    // return MultiCubitProvider(providers: [
    //   CubitProvider<RestaurantCubit>(
    //     create: (BuildContext context) => _restaurantCubit,
    //   ),
    //   CubitProvider<HeaderCubit>(
    //     create: (BuildContext context) => HeaderCubit(),
    //   ),
    //   CubitProvider<AuthCubit>(
    //     create: (BuildContext context) => _authCubit,
    //   )
    // ], child: RestaurantListPage(adapter, service));
  }

  // static Widget _composeSearchResultsPageWith(String query) {
  //   RestaurantCubit restaurantCubit =
  //       RestaurantCubit(_api, defaultPageSize: 10);
  //   ISearchResultsPageAdapter searchResultsPageAdapter =
  //       SearchResultsPageAdapter(onSelection: _composeRestaurantPageWith);
  //   return SearchResultsPage(restaurantCubit, query, searchResultsPageAdapter);
  // }
}
