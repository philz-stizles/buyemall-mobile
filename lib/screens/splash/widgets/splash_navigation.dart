import 'package:flutter/material.dart';
import 'package:mobile/constants.dart';
import 'package:mobile/screens/screens.dart';
import 'package:mobile/size_config.dart';
import 'package:mobile/widgets/widgets.dart';

class SplashNavigation extends StatelessWidget {
  final int pageCount;
  final int currentPage;
  const SplashNavigation({
    Key key, 
    this.pageCount, 
    this.currentPage
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Column(
          children: <Widget>[
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pageCount,
                (index) => AnimatedDot(
                  index: index, 
                  animationDuration: kAnimationDuration, 
                  currentPage: currentPage,
                ),
              ),
            ),
            Spacer(flex: 3),
            DefaultButton(
              text: "Continue",
              press: () {
                Navigator.pushNamed(context, SignInScreen.routeName);
              },
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
