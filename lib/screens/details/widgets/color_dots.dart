import 'package:flutter/material.dart';
import 'package:mobile/models/models.dart';
import 'package:mobile/size_config.dart';
import 'package:mobile/widgets/widgets.dart';

class ColorDots extends StatefulWidget {
  const ColorDots({Key key, this.product}) : super(key: key);

  final Product product;

  @override
  _ColorDotsState createState() => _ColorDotsState();
}

class _ColorDotsState extends State<ColorDots> {
  // Now this is fixed and only for demo
  int selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        children: [
          ...List.generate(
            widget.product.colors.length,
            (index) => ColorDot(
              color: widget.product.colors[index],
              isSelected: index == selectedColor,
              onTap: () {
                setState(() {
                  selectedColor = index;
                });
              },
            ),
          ),
          Spacer(),
          RoundedIconBtn(
            icon: Icons.remove,
            onPress: () {},
          ),
          SizedBox(width: getProportionateScreenWidth(20)),
          RoundedIconBtn(
            icon: Icons.add,
            showShadow: true,
            onPress: () {},
          ),
        ],
      ),
    );
  }
}
