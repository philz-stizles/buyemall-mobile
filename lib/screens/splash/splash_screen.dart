import 'package:flutter/material.dart';
import 'package:mobile/screens/splash/widgets/splash_navigation.dart';
import 'package:mobile/screens/splash/widgets/splash_slider.dart';
import 'package:mobile/size_config.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash-screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final List<Map<String, String>> sliderPages = [
    {
      "text": "Welcome to Tokoto, Let’s shop!",
      "image": "assets/images/splash_1.png"
    },
    {
      "text":
          "We help people conect with store \naround United State of America",
      "image": "assets/images/splash_2.png"
    },
    {
      "text": "We show the easy way to shop. \nJust stay at home with us",
      "image": "assets/images/splash_3.png"
    },
  ];
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Center(
        child: SafeArea(
            child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              SplashSlider(
                sliderPages: sliderPages, 
                currentPage: currentPage,
                onPageChange: (value) => {
                  setState(() {
                    currentPage = value;
                  })
                }
              ),
              SplashNavigation(pageCount: sliderPages.length, currentPage: currentPage)
            ],
          ),
        )),
      ),
    );
  }
}
