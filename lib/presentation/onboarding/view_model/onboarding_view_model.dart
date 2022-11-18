import 'dart:async';
import 'package:firstproject/domain/models/models.dart';
import 'package:firstproject/presentation/base/base_view_model.dart';
import '../../resources/assets_manager.dart';
import '../../resources/string_manager.dart';

class ONBoardingViewModel extends BaseViewModel
    with ONBoardingViewModelInputs, ONBoardingViewModelOutputs {
// Stream controller outputs
  StreamController _streamController = StreamController<SliderViewObject>();
  late final List<SliderObject>_list; //  here we are create variable but not used because before it late
  int _currentIndex = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    _streamController.close(); // to close with this methode
  }

  @override
  void start() {
    // start your view job
    _list = _getSliderData();
    _postDataToView();
  }

  @override
  int goNext() {
    // its return int not widget
    int nextIndex = ++_currentIndex; // now current index  plus  one
    if (nextIndex == _list.length) {
      // this condition when you reach to end of list case
      nextIndex = 0; // this loop to return it again to beginng

    }
    return nextIndex;
  }

  @override
  int goPrevious() {
    // its return int not widget
    int previousIndex = --_currentIndex; // now current index  minus one
    if (previousIndex == -1) {
      // this condition when you reach to sub zero case
      previousIndex = _list.length - 1; // this loop to return it again

    }
    return previousIndex;
  }

  @override
  void onPageChanged(int index) {
    // TODO: implement onPageChanged
    _currentIndex =
        index; // when index changed will affect on _currentIndex which will affected on other parts
    _postDataToView(); // its when it will send data to page view
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  // TODO: implement outSliderViewObject
  Stream<SliderViewObject> get outSliderViewObject =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);
  void _postDataToView() {
    inputSliderViewObject.add(
        SliderViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }

  // onBoarding private functions
  List<SliderObject> _getSliderData() => [
        // so here we created this empty variable

        SliderObject(AppString.onBoardingTitle1, AppString.onBoardingSubTitle1,
            ImageAssets.onBoardingLogo1),
        SliderObject(AppString.onBoardingTitle2, AppString.onBoardingSubTitle2,
            ImageAssets.onBoardingLogo2),
        SliderObject(AppString.onBoardingTitle3, AppString.onBoardingSubTitle3,
            ImageAssets.onBoardingLogo3),
        SliderObject(AppString.onBoardingTitle4, AppString.onBoardingSubTitle4,
            ImageAssets.onBoardingLogo4),
      ];

  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);
}

// inputs means that "orders" which our view model will receive from view
abstract class ONBoardingViewModelInputs {
  int goNext(); // when user press right arrow or swipe left
  int goPrevious(); // when user press left arrow or swipe right
  void onPageChanged(int index);
  Sink get inputSliderViewObject;
}
// streamcontroller inputs

abstract class ONBoardingViewModelOutputs {
  Stream<SliderViewObject> get outputSliderViewObject;
}
