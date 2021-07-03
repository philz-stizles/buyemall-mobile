import 'package:flutter/material.dart';
import 'package:mobile/constants.dart';

class AnimatedDot extends StatelessWidget {
  final int index;
  final Duration animationDuration;
  final int currentPage;

  const AnimatedDot({
    Key key, 
    this.index, 
    this.animationDuration, 
    this.currentPage
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: animationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
