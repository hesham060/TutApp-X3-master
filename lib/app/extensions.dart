import 'package:firstproject/app/constants.dart';

extension nonNullString on String? {         // so we apply extensions with primative variables 
  String orEmpty() {
    if (this == null) {
      return Constants.empty;
    } else {
      return this!;
    }
  }
}

extension nonNullInteger on int? {
  int orZero() {
    if (this == null) {
      return Constants.zero;
    } else {
      return this!;
    }
  }
}

