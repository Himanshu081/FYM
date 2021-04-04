import 'package:flutter/material.dart';
import 'package:fym_test_1/models/Project.dart';
import 'package:fym_test_1/state_management/Projects/ProjectCubit.dart';
// import 'package:fym_test_1/widgets/styles.dart';

class ProjectPage extends StatelessWidget {
  final Project project;
  final ProjectCubit projectCubit;

  const ProjectPage(this.project, this.projectCubit);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black), color: Colors.white),
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // verticalSpaceLarge,
          // verticalSpaceLarge,
          // verticalSpaceLarge,
          Text(
            project.title,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            style: Theme.of(context).textTheme.headline5,
          ),
        ],
      ),
    );
  }
}
