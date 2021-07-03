import 'package:flutter/material.dart';
import 'package:mobile/enums.dart';
import 'package:mobile/screens/home/widgets/categories.dart';
import 'package:mobile/screens/home/widgets/discount_banner.dart';
import 'package:mobile/screens/home/widgets/home_header.dart';
import 'package:mobile/screens/home/widgets/popular_products.dart';
import 'package:mobile/screens/home/widgets/special_offers.dart';
import 'package:mobile/size_config.dart';
import 'package:mobile/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home-screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(20)),
              HomeHeader(),
              SizedBox(height: getProportionateScreenWidth(10)),
              DiscountBanner(),
              Categories(),
              SpecialOffers(),
              SizedBox(height: getProportionateScreenWidth(30)),
              PopularProducts(),
              SizedBox(height: getProportionateScreenWidth(30)),
            ],
          ),),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home)
    );
  }
}