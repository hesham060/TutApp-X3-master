import 'package:flutter/material.dart';

enum langaugeType { ENGLISH, ARABIC }

const String ARABIC = 'ar';
const String ENGLISH = 'en';
const String ASSET_PATH_LOCALISATIONS = "lib/assets/translations";

const Locale ARABIC_LOCAL = Locale("ar", "SA");
const Locale ENGLISH_LOCAL = Locale("en", "US");

extension langaugeTypeExtension on langaugeType {
  String getValue() {
    switch (this) {
      case langaugeType.ENGLISH:
        return ENGLISH;
      case langaugeType.ARABIC:
        return ARABIC;
    }
  }
}
