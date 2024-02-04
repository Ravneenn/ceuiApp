import 'package:flutter/material.dart';

enum Screen {
  mobile,
  tablet,
}

detectScreen(Size size) {
  if (size.width < 700) {
    return Screen.mobile;
  } else {
    return Screen.tablet;
  }
}
