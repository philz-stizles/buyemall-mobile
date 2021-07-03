import 'package:flutter/material.dart';
import 'package:mobile/widgets/no_account_text.dart';
import 'package:mobile/screens/signin/widgets/signin_social.dart';
import 'package:mobile/screens/signin/widgets/signin_form.dart';
import 'package:mobile/size_config.dart';

class SignInScreen extends StatelessWidget {
  static const String routeName = '/signin-screen';

  const SignInScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign In'),),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  Text(
                    "Welcome Back",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(28),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Sign in with your email and password  \nor continue with social media",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.08),
                  SignInForm(),
                  SizedBox(height: SizeConfig.screenHeight * 0.08),
                  SignInSocial(),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  NoAccountText(),
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}