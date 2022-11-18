import 'package:firstproject/presentation/resources/fonts_manager.dart';
import 'package:flutter/cupertino.dart';

TextStyle _getTextStyle(
  // model for making style like regular style and the method name is private
  double fontSize,
  FontWeight fontWeight,
  Color color,
) {
  return TextStyle(
    fontFamily: FontConstant.fontManager,
    fontWeight: fontWeight,
    color: color,
  );
}
 
 // Regular Style
TextStyle getReglarStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
    fontSize,
    FontWeightManager.regular,
    color,
  );
}
// Medium Style
TextStyle getMeduimStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
    fontSize,
    FontWeightManager.medium,
    color,
  );
}

// Light Style
TextStyle getLightStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
    fontSize,
    FontWeightManager.light,
    color,
  );
}

// SemiBole Style
TextStyle getSemiBoldStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
    fontSize,
    FontWeightManager.semiBold,
    color,
  );
}
// bold Style
TextStyle getBoldStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
    fontSize,
    FontWeightManager.bold,
    color,
  );
}