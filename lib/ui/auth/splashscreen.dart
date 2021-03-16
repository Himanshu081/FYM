import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:fym_test_1/auth/src/signup_service.dart';
import 'package:fym_test_1/infra/api/auth_api.dart';
import 'package:fym_test_1/managers/auth_manager.dart';
import 'package:fym_test_1/state_management/auth/auth_cubit.dart';
import 'package:fym_test_1/ui/auth/auth_page.dart';
import 'package:fym_test_1/ui/auth/auth_page_adapters.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatelessWidget {
  final ISignupService signupService;
  final AuthManager manager;
  final IAuthPageAdapter _adapter;
  final AuthApi authapi;

  OnboardingScreen(
      this.signupService, this.manager, this._adapter, this.authapi);
  @override
  Widget build(BuildContext context) {
    const kOrangecolor = Color(0xFFFF7643);
    const kPrimaryColor = Colors.blue;
    const kPrimaryLightColor = Color(0xFFFFECDF);
    const kSecondaryColor = Color(0xFF979797);
    const kTextColor = Color(0xFF757575);
    return SafeArea(
      child: IntroductionScreen(
        pages: [
          PageViewModel(
            title: "Find Your TeamMates",
            body: " Connect with Students and Professionals around the world",
            image: buildImage('assets/team.png'),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: "Featured Projects",
            body: "Work on world class projects of your choice",
            image: buildImage('assets/projects.png'),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: "Simple UI",
            body: "For enhanced User experience",
            image: buildImage('assets/mobile_ux.png'),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: "Get Started",
            body: "Start your journey with us",
            image: buildImage('assets/manthumbs.png'),
            decoration: getPageDecoration(),
          ),
        ],
        done:
            Text('Login/SignUp', style: TextStyle(fontWeight: FontWeight.w600)),
        onDone: () => goToHome(context),
        showSkipButton: true,
        skip: Text('Skip'),
        onSkip: () => goToHome(context),
        next: Icon(Icons.arrow_forward),
        dotsDecorator: getDotDecoration(),
        // onChange: (index) => print('Page $index selected'),
        globalBackgroundColor: Theme.of(context).primaryColor,
        skipFlex: 0,
        nextFlex: 0,
      ),
    );
  }

  void goToHome(context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return CubitProvider.value(
          value: CubitProvider.of<AuthCubit>(context),
          child: AuthPage(signupService, manager, _adapter, authapi));
    }));
    //   // MaterialPageRoute(builder: (_) => HomePage()),
    //   );
  }

  Widget buildImage(String s) {
    return Center(
      child: Image.asset(
        s,
        width: 300,
      ),
    );
  }

  DotsDecorator getDotDecoration() => DotsDecorator(
        color: Color(0xFFBDBDBD),
        //activeColor: Colors.orange,
        size: Size(10, 10),
        activeSize: Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );

  PageDecoration getPageDecoration() => PageDecoration(
        titleTextStyle: GoogleFonts.montserrat(
            fontSize: 26, fontWeight: FontWeight.w500, color: Colors.blue),
        bodyTextStyle: GoogleFonts.montserrat(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.grey),
        descriptionPadding: EdgeInsets.all(16).copyWith(bottom: 0),
        imagePadding: EdgeInsets.all(24),
        pageColor: Colors.white,
      );
}
