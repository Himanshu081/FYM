import 'package:flutter/material.dart';
import 'package:fym_test_1/models/Project.dart';
// import 'package:fym_test_1/state_management/Projects/ProjectCubit.dart';
import 'package:fym_test_1/widgets/styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:fym_test_1/widgets/styles.dart';

class ProjectPage extends StatelessWidget {
  final Project project;

  const ProjectPage(this.project);

  @override
  Widget build(BuildContext context) {
    const kBestSellerColor = Color(0xFFFFD073);
    // const kSecondaryColor = Color(0xFFFE6D8E);
    // const kTextColor = Color(0xFF12153D);
    const kTextLightColor = Color(0xFF9A9BB2);
    // const kFillStarColor = Color(0xFFFCC419);

    const kDefaultPadding = 20.0;

// const kDefaultShadow = BoxShadow(
//   offset: Offset(0, 4),
//   blurRadius: 4,
//   color: Colors.black26,
// );
    int length = project.skills.split(",").length;
    // print(length);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
          width: double.infinity,
          // decoration: BoxDecoration(
          //   color: Color(0xFFF5F4EF),
          //   border: Border.all(color: Colors.black),
          //   image: DecorationImage(
          //     image: AssetImage("assets/detailspage.gif"),
          //     scale: 0.1,
          //     alignment: Alignment.topRight,
          //   ),
          // ),
          margin: EdgeInsets.all(20),
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 4),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Align(
                  //     alignment: Alignment.topRight,
                  //     child: Image.asset(
                  //       "assets/detailspage.gif",
                  //       width: 200,
                  //     )),
                  verticalSpaceSmall,
                  ClipPath(
                    clipper: BestSellerClipper(),
                    child: Container(
                      color: kBestSellerColor,
                      padding: EdgeInsets.only(
                          left: 10, top: 5, right: 20, bottom: 5),
                      child: Text(
                        project.domain.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  verticalSpaceSmall,
                  Text(project.title, style: kHeadingextStyle),
                  verticalSpaceMedium,

                  Text(
                    "Skills Required :",
                    style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ),
                  verticalSpaceSmall,

                  ListView(
                    primary: true,
                    shrinkWrap: true,
                    children: <Widget>[
                      Wrap(
                        spacing: 4.0,
                        runSpacing: 0.0,
                        children: List<Widget>.generate(
                            length, // place the length of the array here
                            (int index) {
                          return Chip(
                              labelPadding: EdgeInsets.all(2.0),
                              backgroundColor: Color(0xFF5f65d3),
                              avatar: CircleAvatar(
                                backgroundColor: Colors.white70,
                                child: Text(project.skills
                                    .split(",")[index][0]
                                    .toUpperCase()),
                              ),
                              label: Text(
                                project.skills.split(",")[index],
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ));
                        }).toList(),
                      ),
                    ],
                  ),
                  verticalSpaceMedium,
                  Stack(children: [
                    Container(
                      // it will cover 90% of our total width
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // borderRadius: BorderRadius.only(
                        //   bottomLeft: Radius.circular(50),
                        //   topLeft: Radius.circular(50),
                        // ),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 5),
                            blurRadius: 50,
                            color: Color(0xFF12153D).withOpacity(0.2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  // SvgPicture.asset("assets/icons/star_fill.svg"),
                                  //
                                  Text(
                                    "Posted By",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey),
                                  ),
                                  SizedBox(height: kDefaultPadding / 4),
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(color: Colors.black),
                                      children: [
                                        TextSpan(
                                          text: "${project.author}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        // TextSpan(text: "10\n"),
                                        // TextSpan(
                                        //   text: "150,212",
                                        //   style: TextStyle(color: kTextLightColor),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            VerticalDivider(),
                            // Rate this
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  // SvgPicture.asset("assets/icons/star.svg"),
                                  Text(
                                    "Members Required",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey),
                                  ),
                                  SizedBox(height: kDefaultPadding / 2),
                                  Text(project.membersReq,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            VerticalDivider(),
                            // Metascore
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(6),
                                    // decoration: BoxDecoration(
                                    //   color: Color(0xFF51CF66),
                                    //   borderRadius: BorderRadius.circular(2),
                                    // ),
                                    child: Text(
                                      "Date of Posting",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey),
                                    ),
                                  ),
                                  SizedBox(height: kDefaultPadding / 4),
                                  Text(
                                    project.dateOfPosting,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ]),
                  verticalSpaceLarge,
                  Text(
                    "Description :",
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ),
                  verticalSpaceSmall,
                  Text(project.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          )),
    );
  }
}

class BestSellerClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var path = Path();
    path.lineTo(size.width - 20, 0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width - 20, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}

// Widget _buildChip(String label, Color color) {
//   return Chip(
//     labelPadding: EdgeInsets.all(2.0),
//     avatar: CircleAvatar(
//       backgroundColor: Colors.white70,
//       child: Text(label[0].toUpperCase()),
//     ),
//     label: Text(
//       label,
//       style: TextStyle(
//         color: Colors.white,
//       ),
//     ),
//     backgroundColor: color,
//     elevation: 6.0,
//     shadowColor: Colors.grey[60],
//     padding: EdgeInsets.all(8.0),
//   );
// }
