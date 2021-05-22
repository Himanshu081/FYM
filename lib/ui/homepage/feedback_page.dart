import 'package:delayed_display/delayed_display.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:fym_test_1/models/PostProject.dart';
import 'package:fym_test_1/models/feedback.dart';
import 'package:fym_test_1/state_management/Projects/User_Projects.dart/getuserprojectCubit.dart';
import 'package:fym_test_1/state_management/Projects/User_Projects.dart/getuserprojectState.dart';
import 'package:fym_test_1/state_management/Projects/User_Projects.dart/postcubit_state.dart';
import 'package:fym_test_1/state_management/Projects/User_Projects.dart/postprojectcubit.dart';
import 'package:fym_test_1/widgets/styles.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedBackScreen extends StatelessWidget {
  // final String username;
  // final String email;

  // FeedBackScreen(this.username, this.email);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // navigationBar: CupertinoNavigationBar(
        //   middle: Text("Add Project"),
        // ),
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   elevation: 0,
        //   iconTheme: IconThemeData(
        //     color: Colors.black, //change your color here
        //   ),
        // title:
        //  Text('Add Project',
        //     style: GoogleFonts.oxygen(
        //         color: Colors.black,
        //         fontSize: 28,
        //         fontWeight: FontWeight.bold)
        //         ),

        body: CubitListener<UserProjectCubit, GetUserProjects>(
      listener: (context, state) {
        if (state is PostFeedbackLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PostFeedbackSuccessState) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(
              state.message,
              style: GoogleFonts.openSans(color: Colors.white),
            ),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 1, milliseconds: 500),
          ));
        } else if (state is GetUserProjectFail) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(state.error,
                style: GoogleFonts.openSans(color: Colors.white)),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 1, milliseconds: 300),
          ));
        }
      },
      child: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 25, 8, 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Submit Feedback ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
              ),
              verticalSpaceSmall,
              Text(
                "Tell us what can we do better,what you love about the app or something that isn't right.",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
              ),
              verticalSpaceRegular,
              Container(
                  // decoration:
                  //     BoxDecoration(border: Border.all(color: Colors.black)),
                  height: 400,
                  child: FeedbackForm())
            ],
          ),
        )),
      ),
    ));
  }
}

class FeedbackForm extends StatefulWidget {
  // final String username;
  // final String email;

  FeedbackForm();
  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final _formKey = GlobalKey<FormState>();
  String _feedbackdescription;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        // scrollDirection: Axis.vertical,
        // physics: const BouncingScrollPhysics(
        //     parent: AlwaysScrollableScrollPhysics()),
        padding: EdgeInsets.all(10),
        children: [
          TextFormField(
            maxLines: 5,
            keyboardType: TextInputType.multiline,
            autofocus: true,

            // keyboardType: TextInputType.number,
            decoration: new InputDecoration(
                // prefixIcon: Icon(Icons.description),
                border: OutlineInputBorder(),
                labelText: 'Feedback',
                hintText: 'Describe the issue you are facing or feedback',
                hintStyle: TextStyle(fontSize: 14)),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please Enter Feedback Description';
              }
              return null;
            },
            onSaved: (value) {
              this._feedbackdescription = value;
            },
          ),
          verticalSpaceSmall,
          Text(
            "Ask us your doubts or describe your issue ,any detail adds to the picture.Existing Feature improvements or New Feature requests are very much welome.",
            style: TextStyle(
                color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w400),
          ),
          verticalSpaceSmall,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FlatButton(
                  color: Colors.white38,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                      side: BorderSide(color: Color(0xffD3D3D3))),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'BACK',
                    style: TextStyle(color: Colors.blue),
                  )),
              FlatButton(
                  color: Colors.blueAccent,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();

                      MyFeedback _feedback = MyFeedback(_feedbackdescription);

                      CubitProvider.of<UserProjectCubit>(context)
                          .postFeedback(_feedback);
                      // context.bloc<PostcontactCubit>().addContact(contact);

                    }
                  },
                  child: Text(
                    'SUBMIT',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
