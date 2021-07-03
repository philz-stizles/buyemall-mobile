import 'package:flutter/material.dart';
import 'package:mobile/screens/screens.dart';
import 'package:mobile/size_config.dart';
import 'package:mobile/widgets/widgets.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(),
          IconBtnWithCounter(
            svgSrc: 'assets/icons/Cart.svg',
           onTap: () => Navigator.pushNamed(context, CartScreen.routeName),
          ),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Bell.svg",
            count: 3,
           onTap: () {},
          ),
        ],
      ),
    );
  }
}