import 'dart:ffi';

import 'package:firstproject/domain/usecase/store_details_usecase.dart';
import 'package:firstproject/presentation/base/base_view_model.dart';
import 'package:firstproject/presentation/common/state_renderer.dart';
import 'package:firstproject/presentation/common/state_renderer_implementer.dart';
import 'package:rxdart/rxdart.dart';
import '../../../domain/models/models.dart';

class StoreDetailsViewModel extends BaseViewModel
    with StoreDetailsInputs, StoreDetailsOutputs {
  final _storeDetailsStreamController = BehaviorSubject<StoreDetails>();

  final StoreDetailsUseCase storeDetailsUseCase;
  StoreDetailsViewModel(this.storeDetailsUseCase);
  @override
  void start() async {
    _localData();
  }

  _localData() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await storeDetailsUseCase.excute(Void)).fold((failure) {
      inputState.add(
          ErrorState(StateRendererType.fullScreenErrorState, failure.message));
    }, (storeDetails) async {
      inputState.add(ContentState());
      // for caching data
      inputStoreDetails.add(storeDetails);
    });
  }

  @override
  Sink get inputStoreDetails => _storeDetailsStreamController.sink;

  @override
  Stream<StoreDetails> get outPutStoreDetails =>
      _storeDetailsStreamController.stream.map((stores) => stores);
  @override
  void dispose() {
    _storeDetailsStreamController.close();
    super.dispose();
  }
}

abstract class StoreDetailsInputs {
  Sink get inputStoreDetails;
}

abstract class StoreDetailsOutputs {
  Stream<StoreDetails> get outPutStoreDetails;
}
