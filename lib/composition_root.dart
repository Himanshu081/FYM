// import 'dart:html';

// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:fym_test_1/Projects/project_api.dart';
import 'package:fym_test_1/Projects/project_api_contract.dart';
import 'package:fym_test_1/Projects/shared_Api_infra/http_client.dart';
import 'package:fym_test_1/Projects/shared_Api_infra/http_client_contract.dart';
import 'package:fym_test_1/auth/src/auth_service_contract.dart';
import 'package:fym_test_1/cache/local_store.dart';
import 'package:fym_test_1/decoraters/secure_client.dart';
import 'package:fym_test_1/infra/api/auth_api_contract.dart';
import 'package:fym_test_1/infra/signup_service.dart';
import 'package:fym_test_1/managers/auth_manager.dart';
import 'package:fym_test_1/models/Project.dart';
import 'package:fym_test_1/state_management/Projects/FilterbyCubit.dart';
import 'package:fym_test_1/state_management/Projects/ProjectCubit.dart';
import 'package:fym_test_1/state_management/auth/auth_cubit.dart';
// import 'package:fym_test_1/ui/auth/auth_page.dart';
import 'package:fym_test_1/ui/auth/auth_page_adapters.dart';
import 'package:fym_test_1/ui/auth/splashscreen.dart';
import 'package:fym_test_1/ui/homepage/Project_Page.dart';
import 'package:fym_test_1/ui/homepage/home_page_adapters.dart';
import 'package:fym_test_1/ui/homepage/homepage.dart';
import 'package:fym_test_1/ui/homepage/search_result_page.dart';
import 'package:fym_test_1/ui/homepage/search_results_page_adapters.dart';
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
  // static Client _client;
  static SecureClient _secureClient;
  static IHttpClient _iHttp;
  static AuthManager manager;
  static ProjectApi _api;
  static AuthApi sut;

  static configure() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    print(_sharedPreferences.toString());
    _localStore = LocalStore(_sharedPreferences);
    _authApi = AuthApi(_baseUrl, _client);

    _client = http.Client();
    _iHttp = HttpClientImpl(_client);
    print("ihttp client creted");
    _secureClient = SecureClient(_iHttp, _localStore);
    print("secure  client creted");

    _baseUrl = "http://192.168.0.6:5000";
    print("heloo from " + _baseUrl);
    manager = AuthManager(_authApi);
    _api = ProjectApi(_secureClient, _baseUrl);
    sut = AuthApi(_baseUrl, _client);
  }

  static Future<Widget> start() async {
    final token = await _localStore.fetch();
    // final authType = await _localStore.fetchAuthType();
    final service = manager.emailAuth("email");
    return token == null ? composeAuthUi() : composeHomeUi(service);
  }

  static Widget composeAuthUi() {
    // print(_baseUrl);
    IAuthApi _api = AuthApi(_baseUrl, _client);
    AuthCubit _authCubit = AuthCubit(_localStore);
    ISignupService _signupService = SignUpService(_api);
    AuthManager manager = AuthManager(_authApi);
    IAuthPageAdapter _adapter =
        AuthPageAdapter(onUserAuthenticated: composeHomeUi);
    // IAuthService _authservice = AuthApi(_baseUrl, _client)

    return CubitProvider(
        create: (BuildContext context) => _authCubit,
        child: OnboardingScreen(_signupService, manager, _adapter, sut));
  }

  static Widget composeHomeUi(IAuthService service) {
    // IProjectApi _api = ProjectApi(_iHttp, _baseUrl);
    ProjectCubit _projectCubit = ProjectCubit(_api);
    // ProjectCubit _restaurantCubit =
    //     ProjectCubit(_api, defaultPageSize: 20);
    IHomePageAdapter adapter = HomePageAdapter(
        onSearch: _composeSearchResultsPageWith,
        onSelection: _composeRestaurantPageWith,
        onLogout: composeAuthUi);
    AuthCubit _authCubit = AuthCubit(_localStore);
    FilterbyCubit _filterbycubit = FilterbyCubit();

    return MultiCubitProvider(providers: [
      CubitProvider<ProjectCubit>(
        create: (BuildContext context) => _projectCubit,
      ),
      CubitProvider<AuthCubit>(
        create: (BuildContext context) => _authCubit,
      ),
      CubitProvider<FilterbyCubit>(
        create: (BuildContext context) => _filterbycubit,
      ),
    ], child: ProjectListPage(adapter, service));
    //   CubitProvider<ProjectCubit>(
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

  static Widget _composeSearchResultsPageWith(String query, String filter) {
    ProjectCubit projectCubit = ProjectCubit(_api);
    ISearchResultsPageAdapter searchResultsPageAdapter =
        SearchResultsPageAdapter(onSelection: _composeRestaurantPageWith);
    return SearchResultsPage(
        projectCubit, query, filter, searchResultsPageAdapter);
  }

  static Widget _composeRestaurantPageWith(Project project) {
    ProjectCubit projectCubit = ProjectCubit(_api);
    return ProjectPage(project, projectCubit);
  }
}
