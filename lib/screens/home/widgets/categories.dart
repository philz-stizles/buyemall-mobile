import 'package:flutter/material.dart';
import 'package:mobile/screens/home/widgets/category_card.dart';
import 'package:mobile/size_config.dart';

class Categories extends StatelessWidget {
  const Categories({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/icons/Flash.svg", "text": "Flash Deal"},
      {"icon": "assets/icons/Bill.svg", "text": "Bill"},
      {"icon": "assets/icons/Game.svg", "text": "Game"},
      {"icon": "assets/icons/Gift.svg", "text": "Daily Gift"},
      {"icon": "assets/icons/Discover.svg", "text": "More"},
      
    ];
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          categories.length,
          (index) => CategoryCard(
            icon: categories[index]["icon"],
            text: categories[index]["text"],
            onPress: () {},
          ),
        ),
      ),
    );
  }
}