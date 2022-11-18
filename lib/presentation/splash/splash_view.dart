import 'dart:async';
import 'package:firstproject/presentation/main_view/main_view.dart';
import 'package:firstproject/presentation/resources/assets_manager.dart';
import 'package:firstproject/presentation/resources/color_manager.dart';
import 'package:firstproject/presentation/resources/constants_manager.dart';
import 'package:firstproject/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';
import '../../app/di.dart';
import '../../app/shared_prefs.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer; // any variable used inside class only we should make private
  final AppPrefreneces _appPrefreneces = instance<AppPrefreneces>();

  _startDelay() {
    _timer = Timer(const Duration(seconds: Appconstants.splashDelay), _goNext);
  }

  _goNext() {
    _appPrefreneces.isUserLoggedIn().then((isUserLoggedIn) => {
          if (isUserLoggedIn)
            {
              // navigate to main screen
              Navigator.pushReplacementNamed(context, Routes.mainRoute)
            }
          else
            {
              _appPrefreneces
                  .isOnBoardingScreenView()
                  .then((isOnBoardingScreenView) => {
                        if (isOnBoardingScreenView)
                          {
                            Navigator.pushReplacementNamed(
                                context, Routes.mainRoute)
                          }
                        else
                          {
                            Navigator.pushReplacementNamed(
                                context, Routes.onBoardingRoute)
                          }
                      })
            }
        });
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Center(child: Image(image: AssetImage(ImageAssets.splashLogo))),
    );
  }

  @override // عشان نتاكد انه انتهي وخلص نستخدم هذه الدالة
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer?.cancel();
  }
}
