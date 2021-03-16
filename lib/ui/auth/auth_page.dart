import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:fym_test_1/auth/src/signup_service.dart';
import 'package:fym_test_1/infra/api/auth_api.dart';
import 'package:fym_test_1/infra/email_auth.dart';
import 'package:fym_test_1/managers/auth_manager.dart';
import 'package:fym_test_1/state_management/auth/auth_cubit.dart';
import 'package:fym_test_1/state_management/auth/auth_state.dart';
import 'package:fym_test_1/auth/src/auth_service_contract.dart';
import 'package:fym_test_1/auth/src/credentail.dart';
import 'package:fym_test_1/ui/auth/auth_page_adapters.dart';
import 'package:fym_test_1/ui/homepage/homepage.dart';
import 'package:fym_test_1/widgets/custom_flat_button.dart';
import 'package:fym_test_1/widgets/custom_outline_button.dart';
import 'package:fym_test_1/widgets/custom_text_field.dart';

class AuthPage extends StatefulWidget {
  final ISignupService signupService;
  final AuthManager manager;
  final IAuthPageAdapter _adapter;
  final AuthApi authapi;

  AuthPage(this.signupService, this.manager, this._adapter, this.authapi);
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  PageController _controller = PageController();

  String _username = '';
  String _email = '';
  String _password = '';
  IAuthService service;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 110.0),
                child: _buildLogo(),
              ),
              SizedBox(height: 50.0),
              CubitConsumer<AuthCubit, AuthState>(builder: (_, state) {
                return _buildUI();
              }, listener: (context, state) {
                if (state is LoadingState) {
                  _showLoader();
                }
                if (state is AuthSuccessState) {
                  widget._adapter.onAuthSuccess(context, service);
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
        alignment: Alignment.center,
        child: Column(children: [
          // SvgPicture.asset(
          //   'assets/logo.svg',
          //   fit: BoxFit.fill,
          // ),
          SizedBox(height: 10.0),
          RichText(
            text: TextSpan(
                text: 'FYM',
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: Colors.black,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                children: [
                  TextSpan(
                    text: ' Space',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                  )
                ]),
          )
        ]),
      );

  _buildUI() => Container(
        height: 500,
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
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            ..._emailAndPassword(),
            SizedBox(height: 30.0),
            CustomFlatButton(
              text: 'Sign in',
              size: Size(double.infinity, 54.0),
              onPressed: () {
                print(_email + " " + _password);
                service = EmailAuth(widget.authapi);
                print("serive is" + service.toString());
                (service as EmailAuth).credential(_email, _password);

                CubitProvider.of<AuthCubit>(context).signin(service);
                // service = widget._manager.service(AuthType.email);
                // (service as EmailAuth)
                //     .credential(email: _email, password: _password);
                // CubitProvider.of<AuthCubit>(context)
                //     .signin(service, AuthType.email);
              },
            ),
            SizedBox(height: 30.0),
            // CustomOutlineButton(
            //   text: 'Sign in with google',
            //   size: Size(double.infinity, 50.0),
            //   icon: SvgPicture.asset(
            //     'assets/google-icon.svg',
            //     height: 18.0,
            //     width: 18.0,
            //     fit: BoxFit.fill,
            //   ),
            //   onPressed: () {
            //     service = widget._manager.service(AuthType.google);
            //     CubitProvider.of<AuthCubit>(context)
            //         .signin(service, AuthType.google);
            //   },
            // ),
            SizedBox(height: 30),
            RichText(
              text: TextSpan(
                text: 'Don\'t have an account?',
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                    ),
                children: [
                  TextSpan(
                    text: ' Sign up',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
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

  _signUp() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            CustomTextField(
              inputAction: TextInputAction.next,
              hint: 'Username',
              fontSize: 18.0,
              fontWeight: FontWeight.normal,
              onChanged: (val) {
                _username = val;
              },
            ),
            SizedBox(height: 30.0),
            ..._emailAndPassword(),
            SizedBox(height: 30.0),
            // CustomFlatButton(
            //   text: 'Sign up',
            //   size: Size(double.infinity, 54.0),
            //   onPressed: () {
            //     final user = User(
            //       name: _username,
            //       email: _email,
            //       password: _password,
            //     );
            //     CubitProvider.of<AuthCubit>(context)
            //         .signup(widget._signUpService, user);
            //   },
            // ),
            SizedBox(height: 30.0),
            SizedBox(height: 30),
            RichText(
              text: TextSpan(
                text: 'Already have an account?',
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                    ),
                children: [
                  TextSpan(
                    text: ' Sign in',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
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
