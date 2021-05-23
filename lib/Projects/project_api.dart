import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fym_test_1/Projects/project_api_contract.dart';
import 'package:fym_test_1/Projects/ProjectMapper.dart';
import 'package:fym_test_1/Projects/shared_Api_infra/http_client_contract.dart';
import 'package:fym_test_1/models/PostProject.dart';
import 'package:fym_test_1/models/Project.dart';
import 'package:fym_test_1/models/feedback.dart';
// import 'package:http/http.dart';

class ProjectApi implements IProjectApi {
  final IHttpClient httpClient;
  final String baseurl;

  ProjectApi(this.httpClient, this.baseurl);

  @override
  Future<List<Project>> findProjects({String searchterm, String filter}) async {
    String endpoint = '';
    if (filter == "Title") {
      endpoint = baseurl + '/project/projects/title?search=$searchterm';
    } else {
      endpoint = baseurl + '/project/projects/skills?search=$searchterm';
    }

    final result = await httpClient.get(endpoint);
    return _parseProjecttoJson(result);
  }

  @override
  Future<List<Project>> searchCategoryWise(String category) async {
    String endpoint = baseurl + '/project/allprojects/$category';
    // if (filter == "Title") {
    //   endpoint = baseurl + '/project/projects/title?search=$searchterm';
    // } else {
    //   endpoint = baseurl + '/project/projects/skills?search=$searchterm';
    // }

    final result = await httpClient.get(endpoint);
    return _parseProjecttoJson(result);
  }

  @override
  Future<List<Project>> getAllProjects() async {
    print("Get all projects of project_api.dart caleed");
    final endpoint = baseurl + '/project/allprojects';
    print(endpoint);
    final result = await httpClient.get(endpoint);
    return _parseProjecttoJson(result);
  }

  @override
  Future<List<Project>> getAllUserProjects({String email}) async {
    print("Get all user projects of project_api.dart caleed");
    final endpoint = baseurl + '/project/projectbyuser/$email';
    print(endpoint);

    final result = await httpClient.get(endpoint);
    print(result.data);
    return _parseProjecttoJson(result);
  }

  @override
  Future<String> addUserProject(PostProject project) async {
    print("Post the  user projects of project_api.dart caleed");
    print(
        "project details received inside adduserproject of project _api.dart::" +
            project.toString());

    final endpoint = baseurl + '/project/createproject';
    final body = jsonEncode({
      "title": project.title,
      "author": project.author,
      "author_email": project.authorEmail,
      "domain": project.domain,
      "members_req": project.membersReq,
      "skills": project.skills,
      "description": project.description,
      "excel_sheet_link": project.excelSl,
      "wp_grp_link": project.wpl
    });
    print(endpoint + body.toString());

    final result = await httpClient.post(endpoint, body);
    print(result.data + result.status.toString());
    if (result.status == Status.failure) return null;
    final json = jsonDecode(result.data);
    print(json['msg']);
    return json['msg'];

    // return _parsePostProjecttoJson(result);
  }

  @override
  Future<String> editUserProject(String id, PostProject project) async {
    print("Edit the  user projects of project_api.dart caleed");
    print(
        "project details received inside edit userproject of project _api.dart::" +
            project.toString());

    final endpoint = baseurl + '/project/updateproject/$id';
    final body = jsonEncode({
      "title": project.title,
      "author": project.author,
      "author_email": project.authorEmail,
      "domain": project.domain,
      "members_req": project.membersReq,
      "skills": project.skills,
      "description": project.description,
      "excel_sheet_link": project.excelSl,
      "wp_grp_link": project.wpl
    });
    print(endpoint + body.toString());

    final result = await httpClient.put(endpoint, body);
    print(result.data + result.status.toString());
    if (result.status == Status.failure) return null;
    final json = jsonDecode(result.data);
    print(json['msg']);
    return json['msg'];
  }

  // _parsePostProjecttoJson()
  @override
  Future<Project> getProject({String id}) async {
    final endpoint = baseurl + '/project/$id';
    final result = await httpClient.get(endpoint);
    if (result.status != Status.failure) return null;
    final json = jsonDecode(result.data);
    return ProjectMapper.fromJson(json);
  }

  List<Project> _parseProjecttoJson(HttpResult result) {
    // print("_parseProjecttoJson calleeddd");
    print(result.status);
    if (result.status == Status.failure) return [];
    final json = jsonDecode(result.data);
    // print("json received ::: " + json.toString());
    // print(json['projects']);
    return json['projects'] != null ? _projectsFromJson(json) : [];
  }

  List<Project> _projectsFromJson(Map<String, dynamic> json) {
    final List projects = json['projects'];
    return projects.map<Project>((e) => ProjectMapper.fromJson(e)).toList();
  }

  @override
  Future<void> deleteUserProject(String id) async {
    print("delete inside project_api called");
    final endpoint = baseurl + '/project/deleteproject/$id';
    print(endpoint);
    final result = await httpClient.delete(endpoint);
    if (result.status != Status.failure)
      return null;
    else {
      print("Deleeted !!");
    }
  }

  @override
  Future<String> postFeedback(MyFeedback feedback, String email) async {
    print("Post the feedbackof project_api.dart caleed");
    // print(
    //     "project details received inside adduserproject of project _api.dart::" +
    //         project.toString());

    final endpoint = baseurl + '/feedback/$email';
    final body = jsonEncode({
      "feedback": feedback.feedback,
    });
    print(endpoint + body.toString());
    try {
      final result = await httpClient.post(endpoint, body);
      print("Result from feedback api ::" +
          result.data +
          result.status.toString());
      if (result.status == Status.failure) return null;
      final json = jsonDecode(result.data);
      print(json['msg']);
      return json['msg'];
    } on SocketException {
      return ('No Internet connection 😑');
    } on HttpException {
      return ("Something went wrong...Please Refresh");
    } on FormatException {
      return ("Something went wrong...Please Restart the app");
    }

    // return _parsePostProjecttoJson(result);
  }
}
