import 'package:flutter/material.dart';
import 'package:mobile/screens/forgot_password/widgets/forgot_password_form.dart';
import 'package:mobile/size_config.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const String routeName = '/forgot-password-screen';

  const ForgotPasswordScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Forgot Password'),
        ),
        body: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  Text(
                    "Forgot Password",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(28),
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Please enter your email and we will send \nyou a link to return to your account",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.1),
                  ForgotPasswordForm(),
                ],
              ),
            ),
          ),
        ));
  }
}
