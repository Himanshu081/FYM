import 'package:flutter/material.dart';
import 'package:fym_test_1/models/Project.dart';
// import 'package:fym_test_1/state_management/Projects/ProjectCubit.dart';

abstract class IHomePageAdapter {
  void onSearchQuery(BuildContext context, String query, String filter);
  void onProjectSelected(BuildContext context, Project project);
  void onUserLogout(BuildContext context);
  void onViewCategoryProject(BuildContext context, String category);
}

class HomePageAdapter implements IHomePageAdapter {
  // ProjectCubit _projectCubit;
  final Widget Function(Project project) onSelection;
  final Widget Function(String query, String filter) onSearch;
  final Widget Function(String category) onParticularCategoryProject;
  final Widget Function() onLogout;
  // final Widget Function() onAddProj;

  HomePageAdapter(
      {@required this.onSelection,
      @required this.onSearch,
      this.onLogout,
      this.onParticularCategoryProject});

  @override
  void onSearchQuery(BuildContext context, String query, String filter) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => onSearch(query, filter),
      ),
    );
  }

  @override
  void onProjectSelected(BuildContext context, Project project) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => onSelection(project),
      ),
    );
  }

  @override
  void onUserLogout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => onLogout(),
        ),
        (Route<dynamic> route) => false);
  }

  @override
  void onViewCategoryProject(BuildContext context, String category) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => onParticularCategoryProject(category)),
    );
  }
}
