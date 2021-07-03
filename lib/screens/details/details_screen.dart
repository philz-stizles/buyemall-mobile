import 'package:flutter/material.dart';
import 'package:mobile/models/models.dart';
import 'package:mobile/screens/details/widgets/color_dots.dart';
import 'package:mobile/screens/details/widgets/product_description.dart';
import 'package:mobile/screens/details/widgets/product_images.dart';
import 'package:mobile/screens/details/widgets/top_rounded_container.dart';
import 'package:mobile/size_config.dart';
import 'package:mobile/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key key}) : super(key: key);

  static const String routeName = '/details-screen';

  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments agrs =
        ModalRoute.of(context).settings.arguments;
    Product product = agrs.product;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F9),
      appBar: CustomAppbar(rating: agrs.product.rating),
      body: ListView(
        children: [
          ProductImages(product: product),
          TopRoundedContainer(
            color: Colors.white,
            child: Column(
              children: [
                ProductDescription(
                  product: product,
                  pressOnSeeMore: () {},
                ),
                TopRoundedContainer(
                  color: Color(0xFFF6F7F9),
                  child: Column(
                    children: [
                      ColorDots(product: product),
                      TopRoundedContainer(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 0.15,
                            right: SizeConfig.screenWidth * 0.15,
                            bottom: getProportionateScreenWidth(40),
                            top: getProportionateScreenWidth(15),
                          ),
                          child: DefaultButton(
                            text: 'Add To Cart',
                            press: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductDetailsArguments {
  ProductDetailsArguments({@required this.product});

  final Product product;
}
