import 'package:cubit/cubit.dart';
import 'package:fym_test_1/Projects/project_api_contract.dart';
// import 'package:fym_test_1/cache/local_store_contract.dart';
import 'package:fym_test_1/models/PostProject.dart';
// import 'package:fym_test_1/models/Project.dart';
// import 'package:fym_test_1/state_management/Projects/User_Projects.dart/getuserprojectState.dart';
import 'package:fym_test_1/state_management/Projects/User_Projects.dart/postcubit_state.dart';
// import 'package:fym_test_1/state_management/Projects/ProjectState.dart';

class UserProjectPostCubit extends Cubit<PostUserProjects> {
  // UserProjectPostCubit(PostUserProjects initialState) : super(PostUserProjectInitial());

  final IProjectApi _api;

  UserProjectPostCubit(this._api) : super(PostUserProjectInitial());

  initialState() {
    emit(PostUserProjectInitial());
  }

  addUserProject(PostProject project) async {
    print("add user Project called inside get project cubit ");
    print("project details received inside postprojectcubit.dart ::" +
        project.toString());
    _startLoading();
    // final email = await store.fetchEmail();
    // print("value of email fetched is" + email.email);
    final addprojectResult = await _api.addUserProject(project);
    // print("Projects received in project cubit " + projectResult.toString());

    addprojectResult == null || addprojectResult.isEmpty
        ? _showError('Some Error occured,Please try again..')
        : _setPageData();
  }

  editUserProject(PostProject project, String id) async {
    print("edit user Project called inside get project cubit ");
    print("project details received inside postprojectcubit.dart ::" +
        project.toString());
    _startLoading();
    // final email = await store.fetchEmail();
    // print("value of email fetched is" + email.email);
    final addprojectResult = await _api.editUserProject(id, project);
    // print("Projects received in project cubit " + projectResult.toString());

    addprojectResult == null || addprojectResult.isEmpty
        ? _showError('Some Error occured,Please try again..')
        : _setPageData();
  }

  _startLoading() {
    emit(PostUserProjectLoading());
  }

  _setPageData() {
    emit(PostUserProjectSuccess());
  }

  _showError(String error) {
    emit(PostUserProjectFail(error));
  }
}
