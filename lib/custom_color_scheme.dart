import 'package:flutter/material.dart';

extension CustomColorScheme on ColorScheme {
  Color get homePageBackground=>brightness==Brightness.light?Color(0xff2052cf):Color(0xff0e255d);
  Color get inActiveBottomNavIconColor=>brightness==Brightness.light?Color(0xff303030):Color(0xffA7A7A7);
  Color get activeBottomNavIconColor=>brightness==Brightness.light?Color(0xff2052cf):Color(0xffFFFFFF);
  Color get iconsColor => brightness == Brightness.light ? Color(0xff666666) : Color(0xffA7A7A7);

  //Color get dashBoardSecondaryTextColor => brightness == Brightness.light ? Color(0xff666666) : Color(0xffA7A7A7);

  Color get forecastCardColor => brightness == Brightness.light ? Color(0xffe6ecfb) : Color(0xff34405e);

  Color get detailsPageTemperatureColor => brightness == Brightness.light ? primary : Color(0xffFFFFFF);
}

//280140