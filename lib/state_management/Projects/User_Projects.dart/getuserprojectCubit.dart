import 'package:cubit/cubit.dart';
import 'package:fym_test_1/Projects/project_api_contract.dart';
import 'package:fym_test_1/cache/local_store_contract.dart';
import 'package:fym_test_1/models/Project.dart';
import 'package:fym_test_1/state_management/Projects/User_Projects.dart/getuserprojectState.dart';
// import 'package:fym_test_1/state_management/Projects/ProjectState.dart';

class UserProjectCubit extends Cubit<GetUserProjects> {
  final IProjectApi _api;
  final ILocalStore store;

  UserProjectCubit(this._api, this.store) : super(GetUserProjectInitial());

  getAllUserProjects() async {
    print("Get all user Projects called inside get project cubit ");
    _startLoading();
    final email = await store.fetchEmail();
    print("value of email fetched is" + email.email);
    final projectResult = await _api.getAllUserProjects(email: email.email);
    print("Projects received in project cubit " + projectResult.toString());

    projectResult == null || projectResult.isEmpty
        ? _showError('No projects found')
        : _setPageData(projectResult);
  }

  _startLoading() {
    emit(GetUserProjectLoading());
  }

  _setPageData(List<Project> result) {
    emit(GetUserProjectSuccess(result));
  }

  _showError(String error) {
    emit(GetUserProjectFail(error));
  }
}
