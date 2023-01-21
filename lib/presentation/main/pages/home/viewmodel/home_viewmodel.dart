import 'dart:async';
import 'dart:ffi';

import 'package:firstproject/presentation/base/base_view_model.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../domain/models/models.dart';
import '../../../../../domain/usecase/home_use_case.dart';
import '../../../../common/state_renderer.dart';
import '../../../../common/state_renderer_implementer.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInput, HomeViewModelOutput {
  final _dataStreamController = BehaviorSubject<HomeViewObject>();

  final HomeUseCase _homeUseCase;

  HomeViewModel(this._homeUseCase);

  // --  inputs
  @override
  void start() {
    _getHomeData();
  }

  _getHomeData() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _homeUseCase.excute(Void)).fold(
        (failure) => {
              // left -> failure
              inputState.add(ErrorState(
                  StateRendererType.fullScreenErrorState, failure.message))
            }, (homeObject) {
      // right -> data (success)
      // content
      inputState.add(ContentState());
     inputHomeData.add(HomeViewObject(homeObject.data.stores, homeObject.data.services, homeObject.data.banners));
    });
  }

  @override
  void dispose() {
    _dataStreamController.close();

    super.dispose();
  }

  @override
  Sink get inputHomeData => _dataStreamController.sink;
  
  @override
  
  Stream<HomeViewObject> get outputHomeData => _dataStreamController.stream.map(((data) => data));

  // -- outputs

}

abstract class HomeViewModelInput {
  Sink get inputHomeData;
}

abstract class HomeViewModelOutput {
  Stream<HomeViewObject> get outputHomeData;
}

class HomeViewObject {
  List<Store> stores;
  List<Service> services;
  List<BannerAd> banners;

  HomeViewObject(this.stores, this.services, this.banners);
}