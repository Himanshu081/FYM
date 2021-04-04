import 'package:equatable/equatable.dart';
import 'package:fym_test_1/models/Project.dart';

abstract class ProjectState extends Equatable {
  const ProjectState();
}

class Initial extends ProjectState {
  const Initial();

  @override
  List<Object> get props => [];
}

class Loading extends ProjectState {
  const Loading();

  @override
  List<Object> get props => [];
}

// class PageLoaded extends ProjectState {
//   // List<Project> get restaurants => _page.restaurants;
//   // final Page _page;
//   // int get nextPage => _page.isLast ? null : this._page.currentPage + 1;

//   // const PageLoaded(this._page);

//   // @override
//   // List<Object> get props => [_page];
// }

class ProjectLoaded extends ProjectState {
  final Project project;

  const ProjectLoaded(this.project);

  @override
  List<Object> get props => [project];
}

class ProjectsLoaded extends ProjectState {
  final List<Project> projects;
  const ProjectsLoaded(this.projects);

  @override
  List<Object> get props => [projects];
}

class ErrorState extends ProjectState {
  final String message;

  const ErrorState(this.message);
  @override
  List<Object> get props => [message];
}
