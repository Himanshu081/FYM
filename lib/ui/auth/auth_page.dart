import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:fym_test_1/auth/src/signup_service.dart';
import 'package:fym_test_1/infra/api/auth_api.dart';
import 'package:fym_test_1/infra/email_auth.dart';
import 'package:fym_test_1/managers/auth_manager.dart';
import 'package:fym_test_1/models/User.dart';
import 'package:fym_test_1/state_management/auth/auth_cubit.dart';
import 'package:fym_test_1/state_management/auth/auth_state.dart';
import 'package:fym_test_1/auth/src/auth_service_contract.dart';
// import 'package:fym_test_1/auth/src/credentail.dart';
import 'package:fym_test_1/ui/auth/auth_page_adapters.dart';
import 'package:fym_test_1/ui/homepage/homepage.dart';
import 'package:fym_test_1/widgets/custom_flat_button.dart';
// import 'package:fym_test_1/widgets/custom_outline_button.dart';
import 'package:fym_test_1/widgets/custom_text_field.dart';
import 'package:fym_test_1/widgets/styles.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthPage extends StatefulWidget {
  final ISignupService _signupService;
  final AuthManager manager;
  final IAuthPageAdapter _adapter;
  final AuthApi authapi;

  AuthPage(this._signupService, this.manager, this._adapter, this.authapi);
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  PageController _controller = PageController();

  String _username = '';
  String _email = '';
  String _password = '';
  String _department = '';
  String _college = '';
  IAuthService service;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white24,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          )),
      resizeToAvoidBottomPadding: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: _buildLogo(),
              ),
              SizedBox(height: 30.0),
              CubitConsumer<AuthCubit, AuthState>(builder: (_, state) {
                return _buildUI();
              }, listener: (context, state) {
                if (state is LoadingState) {
                  _showLoader();
                }
                if (state is AuthSuccessState) {
                  widget._adapter.onAuthSuccess(context, service);
                }
                if (state is SignupSuccessState) {
                  // widget._adapter.onAuthSuccess(context, service);
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        state.result,
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                  );
                  _hideLoader();
                }
                if (state is ErrorState) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        state.message,
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                  );
                  _hideLoader();
                }
              })
            ],
          ),
        ),
      ),
    );
  }

  _buildLogo() => Container(
        // alignment: Alignment.topRight,
        // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Column(children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 12),
            child: Text(
              "Welcome to FYM",
              style: GoogleFonts.montserrat(
                  fontSize: 38, fontWeight: FontWeight.w600),
            ),
          ),
          verticalSpaceSmall,
          Container(
            alignment: Alignment.centerLeft,
            // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            margin: EdgeInsets.only(left: 13, right: 35),
            child: SizedBox(
              child: Text(
                "Fill the following form with correct details . Enjoy Working :)",
                style: ktsMediumBodyText,
              ),
              width: screenWidthPercentage(context, percentage: 0.4),
            ),
          ),
          verticalSpaceTiny
        ]),
      );

  _buildUI() => Container(
        height: 510,
        // decoration: BoxDecoration(border: Border.all(color: Colors.pink)),
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _controller,
          children: [
            _signIn(),
            _signUp(),
          ],
        ),
      );

  _signIn() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            ..._emailAndPassword(),
            SizedBox(height: 30.0),
            CustomFlatButton(
              text: 'Sign in',
              onPressed: () {
                print(_email + " " + _password);
                // service = widget.manager.emailAuth("email");
                service = EmailAuth(widget.authapi);
                print("Service  is" + service.toString());

                (service as EmailAuth).credential(_email, _password);

                CubitProvider.of<AuthCubit>(context).signin(service);
                // service = widget._manager.service(AuthType.email);
                // (service as EmailAuth)
                //     .credential(email: _email, password: _password);
                // CubitProvider.of<AuthCubit>(context)
                //     .signin(service, AuthType.email);
              },
            ),
            verticalSpaceRegular,
            SizedBox(height: 30),
            RichText(
              text: TextSpan(
                text: 'Don\'t have an account?  ',
                style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
                children: [
                  TextSpan(
                    text: 'Sign up',
                    style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: kcprimary),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        _controller.nextPage(
                            duration: Duration(milliseconds: 1000),
                            curve: Curves.elasticOut);
                      },
                  )
                ],
              ),
            )
          ],
        ),
      );

  _signUp() => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              CustomTextField(
                inputAction: TextInputAction.next,
                hint: 'Name',
                fontSize: 18.0,
                fontWeight: FontWeight.normal,
                onChanged: (val) {
                  _username = val;
                },
              ),
              SizedBox(height: 30.0),
              ..._emailAndPassword(),
              SizedBox(height: 30.0),
              CustomTextField(
                // obscure: true,
                inputAction: TextInputAction.done,
                hint: 'College',
                fontSize: 18.0,
                fontWeight: FontWeight.normal,
                onChanged: (val) {
                  _college = val;
                },
              ),
              SizedBox(height: 30.0),

              CustomTextField(
                obscure: true,
                inputAction: TextInputAction.done,
                hint: 'Department',
                fontSize: 18.0,
                fontWeight: FontWeight.normal,
                onChanged: (val) {
                  _department = val;
                },
              ),
              verticalSpaceRegular,
              CustomFlatButton(
                text: 'Sign up',
                onPressed: () {
                  final user = User(
                      name: _username,
                      email: _email,
                      password: _password,
                      department: _department,
                      college: _college);
                  CubitProvider.of<AuthCubit>(context)
                      .signup(widget._signupService, user);
                },
              ),
              SizedBox(height: 30.0),
              // SizedBox(height: 30),
              RichText(
                text: TextSpan(
                  text: 'Already have an account?  ',
                  style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'Sign in',
                      style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.green),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          _controller.previousPage(
                              duration: Duration(milliseconds: 1000),
                              curve: Curves.elasticOut);
                        },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );

  List<Widget> _emailAndPassword() => [
        CustomTextField(
          keyboardType: TextInputType.emailAddress,
          inputAction: TextInputAction.next,
          hint: 'Email',
          fontSize: 18.0,
          fontWeight: FontWeight.normal,
          onChanged: (val) {
            _email = val;
          },
        ),
        SizedBox(height: 30.0),
        CustomTextField(
          obscure: true,
          inputAction: TextInputAction.done,
          hint: 'Password',
          fontSize: 18.0,
          fontWeight: FontWeight.normal,
          onChanged: (val) {
            _password = val;
          },
        )
      ];

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
}
