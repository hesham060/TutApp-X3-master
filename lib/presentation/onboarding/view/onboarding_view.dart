
import 'package:firstproject/app/di.dart';
import 'package:firstproject/app/shared_prefs.dart';
import 'package:firstproject/presentation/onboarding/view_model/onboarding_view_model.dart';
import 'package:firstproject/presentation/resources/assets_manager.dart';
import 'package:firstproject/presentation/resources/color_manager.dart';
import 'package:firstproject/presentation/resources/constants_manager.dart';
import 'package:firstproject/presentation/resources/routes_manager.dart';
import 'package:firstproject/presentation/resources/string_manager.dart';
import 'package:firstproject/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../../../domain/models/models.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);
  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
 final ONBoardingViewModel _viewModel =  ONBoardingViewModel(); 
 final PageController _pageController = PageController();
final AppPrefreneces _appPrefreneces= instance<AppPrefreneces>();
 
 // here to create instant of class
      _bind() {
        _appPrefreneces.setOnBoardingScreenView();
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
      stream: _viewModel.outputSliderViewObject,
      builder: (((context, snapshot) {
        return _getContentWidget(snapshot.data);
      })),
    );
  }

  Widget _getContentWidget(SliderViewObject? sliderViewObject) {
    if (SliderViewObject == null) {
      return Container();
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.white,
          elevation: AppSize.s0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: ColorManager.grey,
              statusBarBrightness: Brightness.dark),
        ),
        // backgroundColor: ColorManager.lightPrimary,
        body: PageView.builder(
          controller: _pageController,
          itemCount: sliderViewObject?.numOfSlides,
          onPageChanged: ((index) {
            _viewModel.onPageChanged(index);
          }),
          itemBuilder: (context, index) =>
              onBoardingPage(sliderViewObject!.sliderObject),
        ),
        bottomSheet: Container(
          color: ColorManager.white,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.loginRoute);
                },
                child: Text(
                  AppString.skip,
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            _getBottomSheetWidget(sliderViewObject),
          ]),
        ),
      );
    }
  }

  Widget _getBottomSheetWidget(SliderViewObject? sliderViewObject) {
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Left Arrow
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              child: SizedBox(
                width: AppSize.s20,
                height: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.leftArrowIc),
              ),
              onTap: () {
                // go to previous slide
                _pageController.animateToPage(_viewModel.goPrevious(),
                    duration: const Duration(
                        milliseconds: Appconstants.SliderAnimationTime),
                    curve: Curves.bounceInOut);
              },
            ),
          ),

          Row(
            children: [
              for (int i = 0; i < sliderViewObject!.numOfSlides; i++)
                /* we are here putted _list
              its means number of pages we shoudnt make int 
               hard code so it will change by numbers of pages automatically*/
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: _getProperCircle(
                    i,
                    sliderViewObject.currentIndex,
                  ), // here i cosider the index which send to widget get proper circle coming from loop for
                )
            ],
          ),
          //right Arrow
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              onTap: () {
                _pageController.animateToPage(_viewModel.goNext(),
                    duration: const Duration(
                        milliseconds: Appconstants.SliderAnimationTime),
                    curve: Curves.bounceInOut);
              },
              child: SizedBox(
                width: AppSize.s20,
                height: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.rightArrowIc),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getProperCircle(int index, int currentIndex) {
    if (index == currentIndex) {
      return SvgPicture.asset(ImageAssets.hollowCirlceIc);
    } else {
      return SvgPicture.asset(ImageAssets.solidCircleic);
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

// when you add ++ after variable so it will add but next time not now so we add it before, means add now not next time

}

class onBoardingPage extends StatelessWidget {
  final SliderObject _sliderObject;
  onBoardingPage(this._sliderObject);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: AppSize.s40,
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.subTitle,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        SvgPicture.asset(_sliderObject.image),
      ],
    );
  }
}
