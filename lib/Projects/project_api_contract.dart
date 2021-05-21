import 'package:flutter/foundation.dart';
import 'package:fym_test_1/models/PostProject.dart';
import 'package:fym_test_1/models/Project.dart';
import 'package:fym_test_1/models/feedback.dart';

abstract class IProjectApi {
  Future<List<Project>> getAllProjects();
  Future<List<Project>> searchCategoryWise(String category);
  Future<String> addUserProject(PostProject project);
  Future<String> postFeedback(MyFeedback feedback, String email);
  Future<void> deleteUserProject(String id);
  Future<String> editUserProject(String id, PostProject project);
  Future<List<Project>> getAllUserProjects({@required String email});
  Future<List<Project>> findProjects(
      {@required String searchterm, @required String filter});
  Future<Project> getProject({@required String id});
}
