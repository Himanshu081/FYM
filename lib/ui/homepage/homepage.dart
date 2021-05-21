import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:fym_test_1/auth/src/auth_service_contract.dart';
import 'package:fym_test_1/auth/src/token.dart';
import 'package:fym_test_1/cache/local_store.dart';
import 'package:fym_test_1/cache/local_store_contract.dart';
// import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:fym_test_1/models/Project.dart';
import 'package:fym_test_1/state_management/Projects/Filterby_state.dart';
import 'package:fym_test_1/state_management/Projects/FilterbyCubit.dart';
import 'package:fym_test_1/state_management/Projects/ProjectCubit.dart';
import 'package:fym_test_1/state_management/Projects/ProjectState.dart';
import 'package:fym_test_1/state_management/Projects/User_Projects.dart/getuserprojectCubit.dart';
import 'package:fym_test_1/state_management/Projects/User_Projects.dart/postprojectcubit.dart';
import 'package:fym_test_1/state_management/auth/auth_cubit.dart';
import 'package:fym_test_1/ui/homepage/feedback_page.dart';
import 'package:fym_test_1/ui/homepage/hire_us_page.dart';
import 'package:fym_test_1/ui/homepage/home_page_adapters.dart';
import 'package:fym_test_1/ui/homepage/userProjectsScreen.dart';
import 'package:fym_test_1/widgets/custom_text_field.dart';
import 'package:fym_test_1/state_management/auth/auth_state.dart' as authState;
// import 'package:fym_test_1/ui/homepage/ProjectListPage.dart';
// import 'package:fym_test_1/widgets/custom_text_field.dart';
import 'package:fym_test_1/widgets/styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProjectListPage extends StatefulWidget {
  final IHomePageAdapter adapter;
  final IAuthService service;
  // final String email;
  // final String username;

  ProjectListPage(this.adapter, this.service);

  @override
  _ProjectListPageState createState() => _ProjectListPageState();
}

// class SortBy {
//   int id;
//   String name;
//   SortBy(this.id, this.name);

//   static List<SortBy> getList() {
//     return <SortBy>[SortBy(1, "Title"), SortBy(2, "Skills")];
//   }
// }

class _ProjectListPageState extends State<ProjectListPage> {
  ProjectsLoaded currentState;
  List<Project> projects = [];
  // List<SortBy> sortby = SortBy.getList();
  // List<DropdownMenuItem<SortBy>> _list;
  // SortBy _selectedFilter;
  List _listItems = ["Title", "Skills"];
  String choosenValue = '';
  // UserName username;
  // Email email;
  // String myemail = '';
  // String myusername = '';
  // String details;
  var myusername = '';
  var myemail = '';
  // SharedPreferences _sharedPreferences =  await SharedPreferences.getInstance();

  @override
  void initState() {
    //
    // print("usrname inside initstate :" + myusername);
    print("init state of homepage called");
    getDetails();

    super.initState();
    // getUserName('CACHED_NAME').then((value) => {myusername += value});

    print(myusername);
    CubitProvider.of<ProjectCubit>(context).getAllProjects();
  }

  getDetails() async {
    var pref = await SharedPreferences.getInstance();
    var username = pref.getString('CACHED_NAME') ?? '';
    var email = pref.getString('CACHED_EMAIL');
    setState(() {
      myusername += username;
      myemail += email;
    });

    return username;
  }
  //   print("get details called");
  //   // details = await CubitProvider.of<AuthCubit>(context).getDetails();
  //   username = await CubitProvider.of<AuthCubit>(context).getUsername();
  //   email = await CubitProvider.of<AuthCubit>(context).getEmail();

  //   // username += myusername.name;
  //   myusername += username.name;
  //   myemail += email.email;
  //   setState(() {
  //     print("value of usename and email inside init state ::" +
  //         myusername +
  //         myemail);
  //   });
  //   // print("username fetched inside getdetails::" + myusername);
  // }
  //   ILocalStore _localStore = LocalStore(_sharedPreferences);
  //   UserName myusername = await _localStore.fetchName();
  //   Email myemail = await _localStore.fetchEmail();
  //   print("username and email fetched is ::" + myusername.name + myemail.email);
  //   username += myusername.name;
  //   email += myemail.email;
  //   print(username + email);
  // }

  @override
  Widget build(BuildContext context) {
    // print("username inside build ::" + myusername + "" + details);
    print("Build method of homepage called");
    print(myusername);
    // getDetails();
    // print(myusername);
    // print(myemail);

    // print(username);

    return Scaffold(
      endDrawer: Drawer(
          elevation: 20.0,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(myusername),
                accountEmail: Text(myemail),
                currentAccountPicture: null,
                decoration: BoxDecoration(color: Colors.blueAccent),
              ),
              ListTile(
                leading: Icon(Icons.business_center_outlined),
                title: Text('Hire Us'),
                onTap: () {
                  // This line code will close drawer programatically....
                  goToHireUsScreen(context);
                  // Navigator.pop(context);
                },
              ),
              Divider(
                height: 2.0,
              ),
              ListTile(
                leading: SizedBox(
                    height: 30,
                    width: 20, // fixed width and height
                    child: Image.asset(
                      'assets/whatsapp.png',
                      color: Color(0xff808080),
                    )),
                title: Text('Join us on Whatsapp'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Divider(
                height: 2.0,
              ),
              ListTile(
                leading: Icon(Icons.error),
                title: Text('Report Issue'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  color: Colors.red,
                ),
                title: Text('Logout'),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          )),
      appBar: AppBar(
        // leading: IconButton(
        //   icon: Icon(Icons.accessible),
        //   onPressed: () => Scaffold.of(context).openDrawer(),
        // ),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: 'FINDYOUR\n',
              children: <TextSpan>[
                TextSpan(
                    text: 'TEAMMATES',
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w300,
                        fontSize: 18,
                        color: Colors.green))
              ],
              style: GoogleFonts.oxygen(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.black)),
        ),
        centerTitle: true,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: new Image.asset(
                "assets/vector-1.png",
                width: 35,
                height: 35,
              ),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(right: 16),
          //   child: IconButton(
          //     icon: Icon(
          //       Icons.power_settings_new_rounded,
          //       size: 26.0,
          //       color: Colors.black,
          //     ),
          //     onPressed: () {
          //       _logout();
          //     },
          //   ),
          // )
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
                      verticalSpaceSmall,
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15, left: 10),
                          child: Text(
                            "Ready to work\ntoday?",
                            style: GoogleFonts.oxygen(
                                fontSize: 27, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: _header(),
                  // alignment: Alignment.topCenter,
                ),
                verticalSpaceRegular,
                verticalSpaceTiny,
                Container(
                  width: double.infinity,
                  height: 100,
                  margin: EdgeInsets.only(left: 10),
                  // decoration:
                  // BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 15),
                        child: Text(
                          "User Corner",
                          style: GoogleFonts.oxygen(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                      userCorner(),
                    ],
                  ),
                ),
                verticalSpaceSmall,
                Container(
                  child: CubitConsumer<ProjectCubit, ProjectState>(
                      builder: (_, state) {
                    if (state is ProjectsLoaded) {
                      currentState = state;
                      if (projects.length != 0) {
                        projects.clear();
                        projects.addAll(state.projects);
                      }
                      projects.clear();
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

  // Future<String> getUserName(String key) async {
  //   var pref = await SharedPreferences.getInstance();
  //   var username = pref.getString(key) ?? '';
  //   return username;
  // }

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

  // void unFocus(BuildContext context) => FocusScope.of(context).unfocus();

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
                widget.adapter.onSearchQuery(context, query, choosenValue);
              },

              //  onSubmitted: adapter.onSearchQuery(context, query),
            ),
            Positioned(
              right: 0,
              child: SvgPicture.asset('assets/background_search.svg'),
            ),
            Positioned(
                top: -5,
                right: -26,
                child: CubitBuilder<FilterbyCubit, FilterByState>(
                  builder: (context, state) {
                    return Container(
                      child: DropdownButton(
                        hint: IconButton(
                          iconSize: 8,
                          icon: Image.asset(
                            'assets/filter.png',
                            color: Colors.white,
                            width: 23,
                          ),
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                          },
                        ),
                        items: _listItems.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value == "Title") {
                            choosenValue = "Title";
                            print(choosenValue);
                            CubitProvider.of<FilterbyCubit>(context)
                                .toggleFilterByTitle(true);
                            CubitProvider.of<FilterbyCubit>(context)
                                .toggleFilterBySkills(false);
                          } else {
                            choosenValue = "Skills";
                            print(choosenValue);
                            CubitProvider.of<FilterbyCubit>(context)
                                .toggleFilterBySkills(true);
                            CubitProvider.of<FilterbyCubit>(context)
                                .toggleFilterByTitle(false);
                          }
                        },
                      ),
                    );
                  },
                ))
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

  Widget mycategory() {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(0.03),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: Wrap(
        runSpacing: 20,
        spacing: 20,
        children: [
          InfoCard(
              title: "Android",
              imagePath: "assets/android.png",
              adapter: widget.adapter),
          InfoCard(
              title: "Web Development",
              imagePath: "assets/coding.png",
              adapter: widget.adapter),
          InfoCard(
              title: "Designing",
              imagePath: "assets/ds.png",
              adapter: widget.adapter),
          InfoCard(
              title: "Marketing",
              imagePath: "assets/dm.png",
              adapter: widget.adapter),
        ],
      ),
    );
  }

  Widget userCorner() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      width: double.infinity,
      height: 55,
      // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: ListView(scrollDirection: Axis.horizontal, children: [
        Row(
          children: [
            ActionChip(
              elevation: 8.0,
              padding: EdgeInsets.all(2.0),
              avatar: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.list_alt_rounded,
                  color: Colors.blue,
                  size: 20,
                ),
              ),
              label: Text(
                'Your Projects',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
              onPressed: () {
                goToUserProjectPage(context, myusername, myemail);
              },
              backgroundColor: Colors.white,
              shape: StadiumBorder(
                  side: BorderSide(
                width: 0.5,
                color: Colors.white,
              )),
            ),
            // horizontalSpaceRegular,
            // ActionChip(
            //   elevation: 8.0,
            //   padding: EdgeInsets.all(2.0),
            //   avatar: CircleAvatar(
            //     backgroundColor: Colors.white,
            //     child: Icon(
            //       Icons.account_box_outlined,
            //       color: Colors.blue,
            //       size: 20,
            //     ),
            //   ),
            //   label: Text(
            //     'Your Profile',
            //     style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            //   ),
            //   onPressed: () {},
            //   backgroundColor: Colors.white,
            //   shape: StadiumBorder(
            //       side: BorderSide(
            //     width: 1,
            //     color: Colors.white,
            //   )),
            // ),
            horizontalSpaceRegular,
            ActionChip(
              elevation: 8.0,
              padding: EdgeInsets.all(2.0),
              avatar: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.error_outline,
                  color: Colors.blue,
                  size: 20,
                ),
              ),
              label: Text(
                'Report Issue',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
              onPressed: () {
                goToFeedbackScreen(context);
              },
              backgroundColor: Colors.white,
              shape: StadiumBorder(
                  side: BorderSide(
                width: 1,
                color: Colors.white,
              )),
            )
          ],
        ),
      ]),
    );
  }

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
            padding: EdgeInsets.only(left: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Top Categories',
                  style: GoogleFonts.oxygen(
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                      color: kBlackColor),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(right: 14),
                  child: Image.asset(
                    'assets/hashtag.png',
                    width: 25,
                    height: 30,
                  ),
                ),
              ],
            ),
          ),
          verticalSpaceMedium,
          mycategory(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 14, top: 25),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Recently Added',
                    style: GoogleFonts.openSans(
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                        color: kBlackColor),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(right: 14, top: 20),
                child: Image.asset(
                  'assets/wall-clock.png',
                  width: 25,
                  height: 30,
                ),
              ),
            ],
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

void goToFeedbackScreen(context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
    return CubitProvider.value(
        value: CubitProvider.of<UserProjectCubit>(context),
        child: FeedBackScreen());
  }));
  // Navigator.of(context)
  //     .push(MaterialPageRoute(builder: (_) => FeedBackScreen()));
}

void goToHireUsScreen(context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (_) => HireUs()));
}

void goToUserProjectPage(context, String username, String email) {
  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
    return MultiCubitProvider(
      providers: [
        CubitProvider.value(
          value: CubitProvider.of<UserProjectCubit>(context),
        ),
        CubitProvider.value(
          value: CubitProvider.of<UserProjectPostCubit>(context),
        ),
      ],
      child: UserProjectsScreen(username, email),
      // child: CubitProvider.value(
      // value: CubitProvider.of<UserProjectCubit>(context),
      // child: UserProjectsScreen()

      // ),
    );
  }));
  //   // MaterialPageRoute(builder: (_) => HomePage()),
  //   );
}

class InfoCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final IHomePageAdapter adapter;
  // final Image PaimagePath,;
  String choosenValue = "Title";

  InfoCard({Key key, this.title, this.imagePath, this.adapter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return InkWell(
        onTap: () {
          if (title == "Android") {
            print("ANDROID CLICKED");
            String query = "Android";
            adapter.onViewCategoryProject(context, query);
          }
          if (title == "Web Development") {
            print("web CLICKED");
            String query = "Web Development";
            adapter.onViewCategoryProject(context, query);
          }
          if (title == "Designing") {
            String query = "Designing";
            print("design CLICKED");
            adapter.onViewCategoryProject(context, query);
          }
          if (title == "Marketing") {
            String query = "Marketing";
            print("marketing CLICKED");
            adapter.onViewCategoryProject(context, query);
          }
        },
        child: Container(
            width: constraints.maxWidth / 2 - 10,
            height: 130,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    // border: Border.all(color: Color(0xffD8D9E4)
                    // )
                  ),
                  child: Image.asset(
                    imagePath,
                    width: 45,
                    alignment: Alignment.center,
                  ),
                ),
                verticalSpaceSmall,
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: Color(0xff3A4276),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )

            //  Container(
            // margin: EdgeInsets.only(right: 10),
            // padding: EdgeInsets.all(16),
            // width: 120,
            // decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(10),
            //     color: Color(0xffF1F3F6)),
            // child: Column(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: <Widget>[
            //     Container(
            //       decoration: BoxDecoration(
            //           shape: BoxShape.circle,
            //           border: Border.all(color: Color(0xffD8D9E4))),
            //       child: Image.asset(
            //         "assets/android.png",
            //         width: 36,
            //       ),
            //     ),
            //     Text(
            //       "Android",
            //       style: GoogleFonts.poppins(
            //         fontSize: 12,
            //         color: Color(0xff3A4276),
            //         fontWeight: FontWeight.w500,
            //       ),
            //     ),
            //   ],
            // ),
            // ),
            ),
      );
    });
  }
}
