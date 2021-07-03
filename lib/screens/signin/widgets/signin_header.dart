import 'package:flutter/material.dart';
import 'package:mobile/size_config.dart';

class SignInHeader extends StatelessWidget {
  const SignInHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
      ],
    );
  }
}