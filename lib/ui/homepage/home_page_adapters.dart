import 'package:flutter/material.dart';
import 'package:fym_test_1/models/Project.dart';
// import 'package:fym_test_1/state_management/Projects/ProjectCubit.dart';

abstract class IHomePageAdapter {
  void onSearchQuery(BuildContext context, String query);
  void onProjectSelected(BuildContext context, Project project);
  void onUserLogout(BuildContext context);
}

class HomePageAdapter implements IHomePageAdapter {
  // ProjectCubit _projectCubit;
  final Widget Function(Project project) onSelection;
  final Widget Function(String query) onSearch;
  final Widget Function() onLogout;

  HomePageAdapter({
    @required this.onSelection,
    @required this.onSearch,
    this.onLogout,
  });

  @override
  void onSearchQuery(BuildContext context, String query) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => onSearch(query),
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
}
