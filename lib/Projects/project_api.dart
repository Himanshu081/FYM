import 'dart:convert';

import 'package:fym_test_1/Projects/project_api_contract.dart';
import 'package:fym_test_1/Projects/ProjectMapper.dart';
import 'package:fym_test_1/Projects/shared_Api_infra/http_client_contract.dart';
import 'package:fym_test_1/models/Project.dart';
// import 'package:http/http.dart';

class ProjectApi implements IProjectApi {
  final IHttpClient httpClient;
  final String baseurl;

  ProjectApi(this.httpClient, this.baseurl);

  @override
  Future<List<Project>> findProjects({String searchterm}) async {
    final endpoint = baseurl + '/project/projects/title?search=$searchterm';
    final result = await httpClient.get(endpoint);
    return _parseProjecttoJson(result);
  }

  @override
  Future<List<Project>> getAllProjects() async {
    print("Get all projects of project_api.dart caleed");
    final endpoint = baseurl + '/project/allprojects';
    print(endpoint);
    final result = await httpClient.get(endpoint);
    print(result.data);
    return _parseProjecttoJson(result);
  }

  @override
  Future<Project> getProject({String id}) async {
    final endpoint = baseurl + '/project/$id';
    final result = await httpClient.get(endpoint);
    if (result.status != Status.failure) return null;
    final json = jsonDecode(result.data);
    return ProjectMapper.fromJson(json);
  }

  List<Project> _parseProjecttoJson(HttpResult result) {
    print("_parseProjecttoJson calleeddd");
    print(result.status);
    if (result.status == Status.failure) return [];
    final json = jsonDecode(result.data);
    print("json received ::: " + json.toString());
    print(json['projects']);
    return json['projects'] != null ? _projectsFromJson(json) : [];
  }

  List<Project> _projectsFromJson(Map<String, dynamic> json) {
    final List projects = json['projects'];
    return projects.map<Project>((e) => ProjectMapper.fromJson(e)).toList();
  }
}
