import 'package:flutter/foundation.dart';
import 'package:fym_test_1/models/Project.dart';

abstract class IProjectApi {
  Future<List<Project>> getAllProjects();
  Future<List<Project>> findProjects(
      {@required String searchterm, @required String filter});
  Future<Project> getProject({@required String id});
}
