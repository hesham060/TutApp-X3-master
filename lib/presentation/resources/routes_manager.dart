import 'package:firstproject/presentation/forgot_password/view/forgot_password_view.dart';
import 'package:firstproject/presentation/login_view/view/login_view.dart';
import 'package:firstproject/presentation/main_view/main_view.dart';
import 'package:firstproject/presentation/register_view/register_view.dart';
import 'package:firstproject/presentation/resources/string_manager.dart';
import 'package:firstproject/presentation/splash/splash_view.dart';
import 'package:firstproject/presentation/store_details_view/store_details.dart';
import 'package:flutter/material.dart';

import '../../app/di.dart';
import '../onboarding/view/onboarding_view.dart';

class Routes {
  static const String splashRoute =
      "/"; // because this first page in app so route coming like this
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgetPasswordRoute = "/forgetPassword";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
  static const String onBoardingRoute = "/onBoarding";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());
      case Routes.loginRoute:
      initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const ResgisterView());
      case Routes.forgetPasswordRoute:
     initForgotPasswordModule();
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.storeDetailsRoute:
        return MaterialPageRoute(builder: (_) => const StoreDetailsView());

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppString.noRouteFound),
              ),
              body: const Center(child: Text(AppString.noRouteFound)),
            ));
  }
}
