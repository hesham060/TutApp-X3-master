import 'package:firstproject/presentation/resources/color_manager.dart';
import 'package:firstproject/presentation/resources/fonts_manager.dart';
import 'package:firstproject/presentation/resources/styles_manager.dart';
import 'package:firstproject/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
// main color
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1,
    splashColor: ColorManager.lightPrimary, // ripple effect
// cardview theme
    cardTheme: CardTheme(
      color: ColorManager.white,
      elevation: AppSize.s4,
      shadowColor: ColorManager.grey,
    ),

// app bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: AppSize.s4,
      color: ColorManager.primary,
      shadowColor: ColorManager.lightPrimary,
      titleTextStyle: getReglarStyle(
        color: ColorManager.white,
        fontSize: FontSize.s16,
      ),
    ),
// button theme

    buttonTheme: ButtonThemeData(
      disabledColor: ColorManager.grey1,
      shape: const StadiumBorder(),
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.lightPrimary,
    ),

// elevated Button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getReglarStyle(
          color: ColorManager.white,
          fontSize: FontSize.s16,
        ),
        primary: ColorManager.primary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s12)),
      ),
    ),

    // text theme
    textTheme: TextTheme(
      bodyMedium: getMeduimStyle(
        color: ColorManager.lightGrey,
        fontSize: FontSize.s14,
      ),
      bodyLarge: getReglarStyle(
        color: ColorManager.grey1,
      ),
      bodySmall: getReglarStyle(
        color: ColorManager.grey,
      ),
      headlineLarge: getSemiBoldStyle(
          color: ColorManager.darkGrey, fontSize: FontSize.s16),
      displayLarge: getSemiBoldStyle(
          color: ColorManager.darkGrey, fontSize: FontSize.s16),
      headlineMedium:
          getReglarStyle(color: ColorManager.darkGrey, fontSize: FontSize.s14),
    ),
    // input Decoration theme

    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(
        AppPadding.p8,
      ),
      hintStyle: getReglarStyle(
        color: ColorManager.grey,
        fontSize: FontSize.s14,
      ),
      labelStyle: getReglarStyle(
        color: ColorManager.grey,
        fontSize: FontSize.s14,
      ),
      errorStyle: getReglarStyle(
        color: ColorManager.error,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.grey,
          width: AppSize.s2,
        ),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.s2,
        ),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.s14,
        ),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
    ),
  );
}
