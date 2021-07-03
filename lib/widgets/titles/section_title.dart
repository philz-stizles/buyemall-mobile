import 'package:flutter/material.dart';
import 'package:mobile/size_config.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final GestureTapCallback onTap;

  const SectionTitle({
    Key key, 
    @required this.title, 
    @required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: Colors.black,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            "See More",
            style: TextStyle(color: Color(0xFFBBBBBB)),
          ),
        ),
      ],
    );
  }
}