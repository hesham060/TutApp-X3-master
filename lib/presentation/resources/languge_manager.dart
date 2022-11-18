enum langaugeType { ENGLISH, ARABIC }

const String ARABIC = 'ar';
const String ENGLISH = 'en';

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
