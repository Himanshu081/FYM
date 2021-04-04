import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:fym_test_1/models/Project.dart';
import 'package:fym_test_1/state_management/Projects/ProjectCubit.dart';
import 'package:fym_test_1/state_management/Projects/ProjectState.dart';
import 'package:fym_test_1/ui/homepage/search_results_page_adapters.dart';

class SearchResultsPage extends StatefulWidget {
  final ProjectCubit projectCubit;
  final String query;
  final ISearchResultsPageAdapter adapter;

  SearchResultsPage(this.projectCubit, this.query, this.adapter);
  @override
  _SearchResultsPageState createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  List<Project> projects = [];
  ProjectsLoaded currentState;
  // bool fetchMore = false;
  @override
  void initState() {
    widget.projectCubit.search(widget.query);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          iconSize: 30.0,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        color: Colors.white,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '${widget.query} Results',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Expanded(
              child: _buildResults(),
            )
          ],
        ),
      ),
    );
  }

  _buildResults() {
    return CubitBuilder<ProjectCubit, ProjectState>(
      cubit: widget.projectCubit,
      builder: (_, state) {
        if (state is ProjectsLoaded) {
          currentState = state;
          projects.addAll(state.projects);
        }
        if (state is ErrorState) {
          return Center(
            child: Text(
              state.message,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          );
        }
        if (currentState == null) {
          return Center(child: CircularProgressIndicator());
        }

        return _buildResultsList();
      },
    );
  }

  _buildResultsList() => ListView.separated(
      itemBuilder: (context, index) {
        return Material(
          child: InkWell(
            onTap: () =>
                widget.adapter.onProjectSelected(context, projects[index]),
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    projects[index].title,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext _, index) => Divider(),
      itemCount: projects.length);
}
