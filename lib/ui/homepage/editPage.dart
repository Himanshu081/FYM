import 'package:delayed_display/delayed_display.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:fym_test_1/models/PostProject.dart';
import 'package:fym_test_1/models/Project.dart';
import 'package:fym_test_1/state_management/Projects/User_Projects.dart/postcubit_state.dart';
import 'package:fym_test_1/state_management/Projects/User_Projects.dart/postprojectcubit.dart';
import 'package:fym_test_1/widgets/styles.dart';
import 'package:google_fonts/google_fonts.dart';

class EditScreen extends StatelessWidget {
  final String username;
  final String email;
  final Project project;

  EditScreen(this.username, this.email, this.project);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // navigationBar: CupertinoNavigationBar(
      //   middle: Text("Add Project"),
      // ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        // title:
        //  Text('Add Project',
        //     style: GoogleFonts.oxygen(
        //         color: Colors.black,
        //         fontSize: 28,
        //         fontWeight: FontWeight.bold)
        //         ),
      ),
      body: CubitBuilder<UserProjectPostCubit, PostUserProjects>(
        builder: (context, state) {
          if (state is PostUserProjectLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PostUserProjectSuccess) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      child: FlareActor(
                        "assets/tick.flr",
                        animation: "done",
                      ),
                      width: 300,
                      height: 300,
                    ),
                  ),
                  DelayedDisplay(
                    child: Text(
                      "Project Edited Successfully !",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  verticalSpaceSmall,
                  DelayedDisplay(
                    delay: Duration(seconds: 1, milliseconds: 200),
                    child: FlatButton(
                        onPressed: () {
                          Navigator.pop(context, 'success');
                          CubitProvider.of<UserProjectPostCubit>(context)
                              .initialState();
                        },
                        color: Colors.green,
                        textColor: Colors.white,
                        child: Text('Go Home')),
                  )
                ],
              ),
            );
          } else if (state is PostUserProjectFail) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.error),
                  FlatButton(
                      onPressed: () {
                        Navigator.pop(context, 'success');
                        CubitProvider.of<UserProjectPostCubit>(context)
                            .initialState();
                      },
                      child: Text('Go Home'))
                ],
              ),
            );
          }
          return SingleChildScrollView(
              child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Edit Project",
                      style: GoogleFonts.oxygen(
                          fontSize: 31, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Edit the following form correctly :",
                      style: GoogleFonts.oxygen(
                          fontSize: 17, fontWeight: FontWeight.w400)),
                ),
                Container(
                    height: 599,
                    // margin: EdgeInsets.all(5),
                    padding: EdgeInsets.only(left: 5, right: 5),
                    // decoration:
                    //     BoxDecoration(border: Border.all(color: Colors.black)),
                    child: ProjectForm(this.project, this.username, this.email))
              ],
            ),
          ));
        },
      ),
    );
  }
}

class ProjectForm extends StatefulWidget {
  final Project project;
  final String username;
  final String email;

  ProjectForm(this.project, this.username, this.email);

  @override
  _ProjectFormState createState() => _ProjectFormState();
}

class _ProjectFormState extends State<ProjectForm> {
  // final Project project;
  // final String username;
  // final String email;
  final _formKey = GlobalKey<FormState>();
  String _title,
      _author,
      _authorEmail,
      _domain,
      _memReq,
      _skills,
      _description,
      _excelLink,
      _wpLink;

  // _ProjectFormState(this.project,this.username,this.email);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        padding: EdgeInsets.all(10),
        children: [
          TextFormField(
            initialValue: widget.project.title,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.title),
                labelText: 'Enter Project Title'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please Enter Project Title';
              }
              return null;
            },
            onSaved: (value) {
              this._title = value;
            },
          ),

          // TextFormField(
          //   // keyboardType: TextInputType.number,
          //   decoration: InputDecoration(
          //       border: OutlineInputBorder(),
          //       labelText: 'Enter Author Name'),
          //   validator: (value) {
          //     if (value.isEmpty) {
          //       return 'Please Enter Author Name';
          //     }
          //     return null;
          //   },
          //   onSaved: (value) {
          //     this._author = value;
          //   },
          // ),

          // TextFormField(
          //   // keyboardType: TextInputType.number,
          //   decoration: InputDecoration(
          //       border: OutlineInputBorder(),
          //       labelText: 'Enter Author Email'),
          //   validator: (value) {
          //     if (value.isEmpty) {
          //       return 'Please Enter Author Email';
          //     }
          //     return null;
          //   },
          //   onSaved: (value) {
          //     this._authorEmail = value;
          //   },
          // ),
          verticalSpaceSmall,
          TextFormField(
            // keyboardType: TextInputType.number,
            initialValue: widget.project.domain,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.domain),
                border: OutlineInputBorder(),
                labelText: 'Enter Project Domain'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please Enter Project Domain';
              }
              return null;
            },
            onSaved: (value) {
              this._domain = value;
            },
          ),
          verticalSpaceSmall,
          TextFormField(
            initialValue: widget.project.membersReq,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.account_box),
                border: OutlineInputBorder(),
                labelText: 'Members Required'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please Enter No. of Members Required';
              }
              return null;
            },
            onSaved: (value) {
              this._memReq = value;
            },
          ),
          verticalSpaceSmall,
          TextFormField(
            initialValue: widget.project.skills,
            // keyboardType: TextInputType.number,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.list),
                border: OutlineInputBorder(),
                labelText: 'Enter Skills Separated by comma'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please Enter Skills';
              }
              return null;
            },
            onSaved: (value) {
              this._skills = value;
            },
          ),
          verticalSpaceSmall,
          TextFormField(
            maxLines: 7,
            initialValue: widget.project.description,

            // keyboardType: TextInputType.number,
            decoration: InputDecoration(

                // prefixIcon: Icon(Icons.description),

                border: OutlineInputBorder(),
                hintText: 'Enter Project Description'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please Enter Project Description';
              }
              return null;
            },
            onSaved: (value) {
              this._description = value;
            },
          ),
          verticalSpaceSmall,
          TextFormField(
            initialValue: widget.project.excelSheetLink,
            //  maxLines: 5,
            // minLines: 2,
            // keyboardType: TextInputType.number,
            decoration: InputDecoration(
                prefixIcon: Image.asset(
                  'assets/google-sheets.png',
                ),
                border: OutlineInputBorder(),
                labelText: 'Google Sheets link'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please Enter Google Sheets link';
              }
              return null;
            },
            onSaved: (value) {
              this._excelLink = value;
            },
          ),
          verticalSpaceSmall,
          TextFormField(
            initialValue: widget.project.wpGrpLink,
            //  maxLines: 5,
            // minLines: 2,
            // keyboardType: TextInputType.number,
            decoration: InputDecoration(
                prefixIcon: Image.asset(
                  'assets/wp.png',
                ),
                border: OutlineInputBorder(),
                labelText: 'Whatsapp Group link'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please Enter Whatsapp Group link';
              }
              return null;
            },
            onSaved: (value) {
              this._wpLink = value;
            },
          ),
          verticalSpaceSmall,
          FlatButton(
              color: Colors.blueAccent,
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  var id = widget.project.sId;
                  PostProject project = PostProject(
                      _title,
                      _author = widget.username,
                      _authorEmail = widget.email,
                      _domain,
                      _memReq,
                      _skills,
                      _description,
                      _excelLink,
                      _wpLink);

                  CubitProvider.of<UserProjectPostCubit>(context)
                      .editUserProject(project, id);
                  // context.bloc<PostcontactCubit>().addContact(contact);

                }
              },
              child: Text(
                'Edit Project',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
