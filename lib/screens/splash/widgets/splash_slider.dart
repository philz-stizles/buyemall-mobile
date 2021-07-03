import 'package:flutter/material.dart';
import 'package:mobile/screens/splash/widgets/slider_content.dart';

class SplashSlider extends StatelessWidget {
  final List<Map<String, String>> sliderPages;
  final int currentPage;
  final Function onPageChange;

  const SplashSlider({
    Key key, 
    this.sliderPages, 
    this.currentPage, 
    this.onPageChange
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: PageView.builder(
        onPageChanged: onPageChange,
        itemCount: sliderPages.length,
        itemBuilder: (context, index) => SliderContent(
          image: sliderPages[index]["image"],
          text: sliderPages[index]['text'],
        ),
      ),
    );
  }
}
