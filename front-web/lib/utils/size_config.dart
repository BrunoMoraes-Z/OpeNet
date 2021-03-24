import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double defaultSize;
  static Orientation orientation;
  static bool started = false;

  void init(BuildContext context) {
    if (!started) {
      _mediaQueryData = MediaQuery.of(context);
      screenWidth = _mediaQueryData.size.width;
      screenHeight = _mediaQueryData.size.height;
      orientation = _mediaQueryData.orientation;
    }
  }

  static double getProportionateScreenHeight(double input) {
    double height = SizeConfig.screenHeight;
    return (height * (input / 100));
    // return (input / (kIsWeb ? 1280 : 812)) * height;
  }

  static double getProportionateScreenWidth(double input) {
    double width = SizeConfig.screenWidth;
    return (width * (input / 100));
    // return (input / (kIsWeb ? 800 : 375)) * width;
  }
}
