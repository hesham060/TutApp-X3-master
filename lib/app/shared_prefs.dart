import 'package:firstproject/presentation/resources/languge_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String Prefs_Key_Lang = "Prefs_Key_Lang";
const String Prefs_Key_OnBoarding_Screen_Viewed =
    "Prefs_Key_OnBoarding_Screen_Viewed";
const String Prefs_Key_Is_User_LoggedIn = "Prefs_Key_Is_User_LoggedIn";

class AppPrefreneces {
  final SharedPreferences _sharedPreferences;

  AppPrefreneces(this._sharedPreferences);
  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(Prefs_Key_Lang);

    //   To avoiding null value or user not set first language so we make this if condition
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return langaugeType.ENGLISH.getValue();
    }
  }

  // onboarding
  Future<void> setOnBoardingScreenView() async {
    _sharedPreferences.setBool(Prefs_Key_OnBoarding_Screen_Viewed, true);
  }

  Future<bool> isOnBoardingScreenView() async {
    return _sharedPreferences.getBool(Prefs_Key_OnBoarding_Screen_Viewed) ??
        false;
  }

// login

  Future<void> setUserLoggedIn() async {
    _sharedPreferences.setBool(Prefs_Key_Is_User_LoggedIn, true);
  }

  Future<bool> isUserLoggedIn() async {
   return _sharedPreferences.getBool(Prefs_Key_Is_User_LoggedIn)??false;
  }
}
