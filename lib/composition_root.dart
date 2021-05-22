// import 'dart:html';

// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:fym_test_1/Projects/project_api.dart';
// import 'package:fym_test_1/Projects/project_api_contract.dart';
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
import 'package:fym_test_1/state_management/Projects/User_Projects.dart/getuserprojectCubit.dart';
import 'package:fym_test_1/state_management/Projects/User_Projects.dart/postprojectcubit.dart';
import 'package:fym_test_1/state_management/auth/auth_cubit.dart';
// import 'package:fym_test_1/ui/auth/auth_page.dart';
import 'package:fym_test_1/ui/auth/auth_page_adapters.dart';
import 'package:fym_test_1/ui/auth/splashscreen.dart';
import 'package:fym_test_1/ui/homepage/Project_Page.dart';
import 'package:fym_test_1/ui/homepage/category_search_results.dart';
import 'package:fym_test_1/ui/homepage/home_page_adapters.dart';
import 'package:fym_test_1/ui/homepage/homepage.dart';
import 'package:fym_test_1/ui/homepage/search_result_page.dart';
import 'package:fym_test_1/ui/homepage/search_results_page_adapters.dart';
import 'package:fym_test_1/ui/homepage/userProjectsScreen.dart';
import 'auth/src/token.dart';
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
  // static UserName username;
  // static Email email;
  // static var myusername1 = '';

  static configure() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    // print(_sharedPreferences.toString());
    _localStore = LocalStore(_sharedPreferences);
    _authApi = AuthApi(_baseUrl, _client);

    _client = http.Client();
    _iHttp = HttpClientImpl(_client);
    // print("ihttp client creted");
    _secureClient = SecureClient(_iHttp, _localStore);
    // print("secure  client creted");

    _baseUrl = "http://192.168.0.3:5000";
    // print("heloo from " + _baseUrl);
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

  // static Future<Widget> getDetails() async {
  //
  //   final myemail = await _localStore.fetchEmail();
  //   username = myusername;
  //   email = myemail;
  // }
  // static getUsername() async {
  //   final myusername = await _localStore.fetchName();
  //   myusername1 += myusername.name;

  //   // return myusername.m;
  // }

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
    // final UserName username =  _localStore.fetchName();
    // print("inside compose home ui");

    // // getUsername();
    // print("username inside comopose home ui ::" + myusername1);

    // String myemail = email.email;
    // getDetails();
    ProjectCubit _projectCubit = ProjectCubit(_api);
    UserProjectCubit userProjectCubit = UserProjectCubit(_api, _localStore);
    UserProjectPostCubit userProjectPostCubit = UserProjectPostCubit(_api);
    // ProjectCubit _restaurantCubit =
    //     ProjectCubit(_api, defaultPageSize: 20);
    IHomePageAdapter adapter = HomePageAdapter(
      onSearch: _composeSearchResultsPageWith,
      onSelection: _composeRestaurantPageWith,
      onLogout: composeAuthUi,
      onParticularCategoryProject: _composeCategoryWisepage,
    );

    AuthCubit _authCubit = AuthCubit(_localStore);
    FilterbyCubit _filterbycubit = FilterbyCubit();

    return MultiCubitProvider(providers: [
      CubitProvider<ProjectCubit>(
        create: (BuildContext context) => _projectCubit,
      ),
      CubitProvider<UserProjectCubit>(
        create: (BuildContext context) => userProjectCubit,
      ),
      CubitProvider<AuthCubit>(
        create: (BuildContext context) => _authCubit,
      ),
      CubitProvider<FilterbyCubit>(
        create: (BuildContext context) => _filterbycubit,
      ),
      CubitProvider<UserProjectPostCubit>(
        create: (BuildContext context) => userProjectPostCubit,
      ),
    ], child: ProjectListPage(adapter, service));
  }

  static Widget _composeSearchResultsPageWith(String query, String filter) {
    ProjectCubit projectCubit = ProjectCubit(_api);
    ISearchResultsPageAdapter searchResultsPageAdapter =
        SearchResultsPageAdapter(onSelection: _composeRestaurantPageWith);
    return SearchResultsPage(
        projectCubit, query, filter, searchResultsPageAdapter);
  }

  static Widget _composeRestaurantPageWith(Project project) {
    // ProjectCubit projectCubit = ProjectCubit(_api);
    return ProjectPage(project);
  }

  static Widget _composeCategoryWisepage(String category) {
    ProjectCubit projectCubit = ProjectCubit(_api);
    ISearchResultsPageAdapter searchResultsPageAdapter =
        SearchResultsPageAdapter(onSelection: _composeRestaurantPageWith);
    return CategorySearchResult(
        projectCubit, category, searchResultsPageAdapter);
  }

  // static Widget composeUserProject() {
  //   UserProjectCubit userProjectCubit = UserProjectCubit(_api, _localStore);
  //   //  IHomePageAdapter adapter = HomePageAdapter(
  //   //     onSearch: _composeSearchResultsPageWith,
  //   //     onSelection: _composeRestaurantPageWith,
  //   //     onLogout: composeAuthUi,
  //   //     onAddProj: composeUserProject);
  //   return UserProjectsScreen(userProjectCubit);
  // }

  // static Widget _composeRestaurantPageWith(Project project){
  //   ProjectCubit projectCubit = ProjectCubit(_api);
  //   return ProjectPage(project, projectCubit);
  // }
}
