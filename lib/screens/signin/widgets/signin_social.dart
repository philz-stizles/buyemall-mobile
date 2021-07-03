import 'package:flutter/material.dart';
import 'package:mobile/widgets/widgets.dart';

class SignInSocial extends StatelessWidget {
  const SignInSocial({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialCard(
          icon: "assets/icons/google.svg",
          onPress: () {},
        ),
        SocialCard(
          icon: "assets/icons/facebook.svg",
          onPress: () {},
        ),
        SocialCard(
          icon: "assets/icons/twitter.svg",
          onPress: () {},
        ),
      ],
    );
  }
}