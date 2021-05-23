import 'package:cubit/cubit.dart';
import 'package:fym_test_1/Projects/project_api_contract.dart';
import 'package:fym_test_1/cache/local_store_contract.dart';
import 'package:fym_test_1/models/Project.dart';
import 'package:fym_test_1/models/feedback.dart';
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
        ? _showError(
            'Something went wrong...Please Check your connection or try again later')
        : _setPageData(projectResult);
  }

  postFeedback(MyFeedback feedback) async {
    print("post feeedback called inside get project cubit ");
    _startFeedbackLoading();
    final email = await store.fetchEmail();
    final feedbackResult = await _api.postFeedback(feedback, email.email);
    feedbackResult == null || feedbackResult.isEmpty
        ? _showError('Something Went Wrong..Please try again later')
        : _setFeedBackData(feedbackResult);
  }

  deleteUserProject(String id) async {
    print("Delte user project called");
    print(id);
    _startLoading();
    _api.deleteUserProject(id).then((value) => getAllUserProjects()).catchError(
        (e) => emit(_showError("Cannot Delete..Please try again later..")));
  }

  _startLoading() {
    emit(GetUserProjectLoading());
  }

  _startFeedbackLoading() {
    emit(PostFeedbackLoading());
  }

  _setPageData(List<Project> result) {
    emit(GetUserProjectSuccess(result));
  }

  _setFeedBackData(String result) {
    emit(PostFeedbackSuccessState(result));
  }

  _showError(String error) {
    emit(GetUserProjectFail(error));
  }
}
