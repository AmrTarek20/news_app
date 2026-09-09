import 'package:flutter/material.dart';

class R {
  static const double designWidth = 375;
  static const double designHeight = 812;

  static double w(BuildContext context, double width) {
    return width * MediaQuery.of(context).size.width / designWidth;
  }

  static double h(BuildContext context, double height) {
    return height * MediaQuery.of(context).size.height / designHeight;
  }

  static double sp(BuildContext context, double size) {
    double scaleFactor = MediaQuery.of(context).size.width / designWidth;

    return (size * scaleFactor).clamp(size * 0.85, size * 1.2);
  }

  static double radius(BuildContext context, double radius) {
    return radius * MediaQuery.of(context).size.width / designWidth;
  }
}
