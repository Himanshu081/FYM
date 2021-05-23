import 'dart:async';
import 'dart:io';

import 'package:cubit/cubit.dart';
import 'package:fym_test_1/Projects/project_api_contract.dart';
import 'package:fym_test_1/models/Project.dart';
import 'package:fym_test_1/state_management/Projects/ProjectState.dart';

class ProjectCubit extends Cubit<ProjectState> {
  final IProjectApi _api;

  ProjectCubit(this._api) : super(Initial());

  getAllProjects() async {
    // print("Get all Projects called inside project cubit ");
    _startLoading();

    final projectResult = await _api.getAllProjects();
    //print("Projects received in project cubit " + projectResult.toString());
    projectResult == null || projectResult.isEmpty
        ? _showError(
            'Something went wrong..Please Check your connection or Try again later')
        : _setPageData(projectResult);
  }

  search(String query, String filter) async {
    _startLoading();

    final searchResults =
        await _api.findProjects(searchterm: query, filter: filter);
    searchResults == null || searchResults.isEmpty
        ? _showError('No Projects found')
        : _setPageData(searchResults);
  }

  searchCategorywise(String category) async {
    _startLoading();

    final searchResults = await _api.searchCategoryWise(category);
    searchResults == null || searchResults.isEmpty
        ? _showError('No Projects found')
        : _setPageData(searchResults);
  }

  getProject(String id) async {
    _startLoading();
    final project = await _api.getProject(id: id);
    project != null
        ? emit(ProjectLoaded(project))
        : emit(ErrorState('Project not found'));
  }

  _startLoading() {
    emit(Loading());
  }

  _setPageData(List<Project> result) {
    emit(ProjectsLoaded(result));
  }

  _showError(String error) {
    emit(ErrorState(error));
  }

  errorState() {
    emit(DisplayErrorState(
        'Something is not Right...Please Check your connection or Try again later'));
  }
}
