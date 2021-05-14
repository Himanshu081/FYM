import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:fym_test_1/models/Project.dart';
import 'package:fym_test_1/state_management/Projects/User_Projects.dart/getuserprojectCubit.dart';
import 'package:fym_test_1/state_management/Projects/User_Projects.dart/getuserprojectState.dart';
import 'package:fym_test_1/state_management/Projects/User_Projects.dart/postprojectcubit.dart';
import 'package:fym_test_1/ui/homepage/addScreen.dart';
import 'package:fym_test_1/ui/homepage/editPage.dart';
import 'package:fym_test_1/widgets/styles.dart';
import 'package:google_fonts/google_fonts.dart';

class UserProjectsScreen extends StatefulWidget {
  // final UserProjectCubit userProjectCubit;

  // UserProjectsScreen(this.userProjectCubit);
  final String username;
  final String email;

  UserProjectsScreen(this.username, this.email);

  @override
  _UserProjectsScreenState createState() => _UserProjectsScreenState();
}

class _UserProjectsScreenState extends State<UserProjectsScreen> {
  @override
  void initState() {
    // widget.userProjectCubit.getAllUserProjects();
    CubitProvider.of<UserProjectCubit>(context).getAllUserProjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Projects List'),
      // ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      floatingActionButton: new FloatingActionButton.extended(
          label: Text('Add Project'),
          tooltip: 'Add Projects',
          icon: Icon(Icons.add),
          onPressed: () async {
            // var result=await Navigator.of(context)
            var result = await Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) {
              return CubitProvider.value(
                  value: CubitProvider.of<UserProjectPostCubit>(context),
                  child: AddScreen(widget.username, widget.email));
            }));
            if (result != null && result == "success") {
              CubitProvider.of<UserProjectCubit>(context).getAllUserProjects();
            }
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: CubitBuilder<UserProjectCubit, GetUserProjects>(
        builder: (context, state) {
          if (state is GetUserProjectLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetUserProjectSuccess) {
            List<Project> projects = state.userProjects;
            return projects != null
                ? SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Your Projects",
                              style: GoogleFonts.oxygen(
                                  fontSize: 31, fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                              "These Projects will be displayed to  others users of FYM. Edit or delete your projects here",
                              style: GoogleFonts.oxygen(
                                  fontSize: 15, fontWeight: FontWeight.w400)),
                        ),
                        Container(
                          width: double.infinity,
                          height: 600,
                          // decoration:
                          //     BoxDecoration(border: Border.all(color: Colors.black)),
                          child: ListView.builder(
                              itemCount: projects.length,
                              scrollDirection: Axis.vertical,
                              physics: const BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                              itemBuilder: (context, index) {
                                return listItem(projects[index]);
                              }),
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: Text("No Projects Found. Add Now ! "),
                  );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget listItem(Project project) {
    return Container(
      margin: EdgeInsets.fromLTRB(2, 10, 5, 2),
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
          // color: Colors.white,
          // border: Border(
          //   bottom: BorderSide(width: 2.0, color: Colors.grey),
          // ),fffff
          // boxShadow: [
          //   BoxShadow(
          //     offset: Offset(0, 5),
          //     blurRadius: 5,
          //     color: Color(0xFF12153D).withOpacity(0.2),
          //   ),
          // ],
          ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(project.title,
                      style: GoogleFonts.oxygen(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold))),
                  verticalSpaceSmall,
                  Text(project.author,
                      style: GoogleFonts.oxygen(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w300))),
                  verticalSpaceSmall,
                ],
              ),
              Row(
                children: [
                  IconButton(
                      icon: const Icon(
                        Icons.edit,
                        size: 19,
                      ),
                      tooltip: 'Edit Project',
                      onPressed: () async {
                        // var result=await Navigator.of(context)
                        var result = await Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return CubitProvider.value(
                              value: CubitProvider.of<UserProjectPostCubit>(
                                  context),
                              child: EditScreen(
                                  widget.username, widget.email, project));
                        }));
                        if (result != null && result == "success") {
                          CubitProvider.of<UserProjectCubit>(context)
                              .getAllUserProjects();
                        }
                      }),
                  VerticalDivider(),
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      size: 19,
                    ),
                    tooltip: 'Delete Project',
                    onPressed: () {
                      print(project.sId);
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
