import 'package:flutter/material.dart';
import 'package:fym_test_1/models/Project.dart';

abstract class ISearchResultsPageAdapter {
  void onProjectSelected(BuildContext context, Project project);
}

class SearchResultsPageAdapter implements ISearchResultsPageAdapter {
  final Widget Function(Project project) onSelection;

  SearchResultsPageAdapter({@required this.onSelection});
  @override
  void onProjectSelected(BuildContext context, Project project) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => onSelection(project),
      ),
    );
  }
}
