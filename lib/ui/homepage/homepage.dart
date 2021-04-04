import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:fym_test_1/auth/src/auth_service_contract.dart';
// import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:fym_test_1/models/Project.dart';
import 'package:fym_test_1/state_management/Projects/ProjectCubit.dart';
import 'package:fym_test_1/state_management/Projects/ProjectState.dart';
import 'package:fym_test_1/state_management/auth/auth_cubit.dart';
import 'package:fym_test_1/ui/homepage/home_page_adapters.dart';
import 'package:fym_test_1/widgets/custom_text_field.dart';
import 'package:fym_test_1/state_management/auth/auth_state.dart' as authState;
// import 'package:fym_test_1/ui/homepage/ProjectListPage.dart';
// import 'package:fym_test_1/widgets/custom_text_field.dart';
import 'package:fym_test_1/widgets/styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProjectListPage extends StatefulWidget {
  final IHomePageAdapter adapter;
  final IAuthService service;

  ProjectListPage(this.adapter, this.service);

  @override
  _ProjectListPageState createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
  ProjectsLoaded currentState;
  List<Project> projects = [];

  @override
  void initState() {
    CubitProvider.of<ProjectCubit>(context).getAllProjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              icon: Icon(
                Icons.power_settings_new_rounded,
                size: 26.0,
                color: Colors.black,
              ),
              onPressed: () {
                _logout();
              },
            ),
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(" Hi !",
                              style: GoogleFonts.openSans(
                                fontSize: 16,
                              )),
                          horizontalSpaceSmall,
                          Image.asset(
                            'assets/waving-hand.png',
                            width: 25,
                            height: 30,
                          )
                        ],
                      ),
                      verticalSpaceSmall,
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Discover Latest Projects",
                          style: GoogleFonts.openSans(
                              fontSize: 22, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: _header(),
                  // alignment: Alignment.topCenter,
                ),
                Container(
                  child: CubitConsumer<ProjectCubit, ProjectState>(
                      builder: (_, state) {
                    if (state is ProjectsLoaded) {
                      currentState = state;
                      projects.addAll(state.projects);
                      // _updateHeader();
                    }

                    if (currentState == null)
                      return Center(child: CircularProgressIndicator());

                    return _buildListOfProjects();
                  }, listener: (context, state) {
                    if (state is ErrorState) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(
                          state.message,
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(color: Colors.white, fontSize: 16.0),
                        ),
                      ));
                    }
                  }),
                ),
                Align(
                  alignment: Alignment.center,
                  child: CubitListener<AuthCubit, authState.AuthState>(
                      child: Container(
                        width: 0.0,
                        height: 0.0,
                      ),
                      listener: (context, state) {
                        if (state is authState.LoadingState) {
                          return _showLoader();
                        }
                        if (state is authState.SignOutSuccessState) {
                          widget.adapter.onUserLogout(context);
                        }
                        if (state is authState.ErrorState) {
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                state.message,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                    ),
                              ),
                            ),
                          );
                          _hideLoader();
                        }
                      }),
                )
              ]),
        ),
      ),
    );
  }

  _logout() {
    CubitProvider.of<AuthCubit>(context).signout(widget.service);
  }

  _showLoader() {
    var alert = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white70,
        ),
      ),
    );

    showDialog(
        context: context, barrierDismissible: true, builder: (_) => alert);
  }

  _hideLoader() {
    Navigator.of(context, rootNavigator: true).pop();
  }

  _header() => Container(
        // decoration: BoxDecoration(color: Theme.of(context).accentColor),
        height: 40.0,
        margin: EdgeInsets.only(left: 25, right: 25, top: 18),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: kLightGreyColor),
        child: Stack(
          children: [
            CustomTextField(
              height: 48,
              hint: "Search Projects",
              onChanged: (val) {},
              inputAction: TextInputAction.search,
              onSubmitted: (query) {
                widget.adapter.onSearchQuery(context, query);
              },

              //  onSubmitted: adapter.onSearchQuery(context, query),
            ),
            Positioned(
              right: 0,
              child: SvgPicture.asset('assets/background_search.svg'),
            ),
            Positioned(
              top: 8,
              right: 9,
              child: SvgPicture.asset('assets/icon_search_white.svg'),
            )
            //     Padding(
            //       padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 50.0),
            //       child: Align(
            //         child: CustomTextField(
            //           hint: 'Find Projects',
            //           fontSize: 14,
            //           height: 40,
            //           fontWeight: FontWeight.normal,
            //           onChanged: (val) {},
            //         ),
            //       ),
            //     )
          ],
        ),
      );
  Widget contentCategory() {
    return Container(
      height: 100,
      padding: EdgeInsets.all(2.5),
      margin: EdgeInsets.only(left: 5),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          // Container(
          //     width: 80,
          //     padding: EdgeInsets.all(18),
          //     child: RaisedButton(
          //       onPressed: () {},
          //       elevation: 0,
          //       padding: EdgeInsets.all(12),
          //       child: Text(
          //         "+",
          //         style: TextStyle(color: Color(0xff1B1D28), fontSize: 22),
          //       ),
          //       shape: CircleBorder(),
          //       color: Color(0xffFFAC30),
          //     )),
          Container(
            margin: EdgeInsets.only(right: 10),
            padding: EdgeInsets.all(16),
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xffF1F3F6)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xffD8D9E4))),
                  child: Image.asset(
                    "assets/android.png",
                    width: 36,
                  ),
                ),
                Text(
                  "Android",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Color(0xff3A4276),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10),
            padding: EdgeInsets.all(7),
            width: 125,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xffF1F3F6)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xffD8D9E4))),
                  child: Image.asset(
                    "assets/web.png",
                    width: 36,
                  ),
                ),
                Text(
                  "Web Development",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Color(0xff3A4276),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10),
            padding: EdgeInsets.all(16),
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xffF1F3F6)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xffD8D9E4))),
                  child: Image.asset(
                    "assets/marketing.png",
                    width: 36,
                  ),
                ),
                Text(
                  "Marketing",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Color(0xff3A4276),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10),
            padding: EdgeInsets.all(16),
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xffF1F3F6)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xffD8D9E4))),
                  child: Image.asset(
                    "assets/design.png",
                    width: 36,
                  ),
                ),
                Text(
                  "Designing",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Color(0xff3A4276),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildListOfProjects() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpaceMedium,
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'Top Categories',
              style: GoogleFonts.openSans(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: kBlackColor),
            ),
          ),
          verticalSpaceMedium,
          contentCategory(),

          Padding(
            padding: EdgeInsets.only(left: 14, top: 25),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Popular',
                style: GoogleFonts.openSans(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: kBlackColor),
              ),
            ),
          ),

          ListView.builder(
              padding: EdgeInsets.only(top: 25, right: 25, left: 25),
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: projects.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // print(projects[index].title);
                    widget.adapter.onProjectSelected(context, projects[index]);
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => SelectedBookScreen(
                    //         popularBookModel: populars[index]),
                    //   ),
                    // );
                  },
                  child: Container(
                      margin: EdgeInsets.only(bottom: 19),
                      height: 81,
                      decoration: BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: kTenBlackColor,
                            blurRadius: 10,
                            spreadRadius: 5,
                            offset: Offset(8.0, 8.0),
                          )
                        ],
                      ),
                      width: MediaQuery.of(context).size.width - 50,
                      // color: kBackgroundColor,
                      child: Container(
                        padding: EdgeInsets.only(left: 15, top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              projects[index].title,
                              style: GoogleFonts.openSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: kBlackColor),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              projects[index].author,
                              style: GoogleFonts.openSans(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: kGreyColor),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              projects[index].domain,
                              style: GoogleFonts.openSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: kBlackColor),
                            )
                          ],
                        ),
                      )),
                );
              }),
          // Container(
          //   height: 500,
          //   child: ListView.builder(
          //       itemCount: projects.length,
          //       scrollDirection: Axis.vertical,
          //       shrinkWrap: true,
          //       itemBuilder: (context, index) {
          //         return ProjectListItem(
          //           project: projects[index],
          //         );
          //       }),
          // ),
        ],
      ),
    );
  }
}
