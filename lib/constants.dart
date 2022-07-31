import 'package:flutter/material.dart';

const kDarkBlue = Color(0XFF6097B2);
const kLightBlue = Color(0XFF92dae6);
const kLightGreen=Color(0XFFb9e0d3);
const kButtonBlue=Color(0XFF6097b2);

kNavigator(context, page) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => page),
  );
}
kNavigatorreplace(context, page) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context) => page),
  );
}

kNavigatorBack(context) {
  Navigator.of(context).pop();
}
