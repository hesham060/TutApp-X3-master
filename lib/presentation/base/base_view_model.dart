import 'dart:async';
import 'package:firstproject/presentation/common/state_renderer_implementer.dart';
import 'package:rxdart/rxdart.dart';


abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOuts {
  // shared variable and function that we will use through any view model
  // we create here because will use many places
  final StreamController _inputStreamController =
      BehaviorSubject<FlowState>();

  @override
  Sink get inputState => _inputStreamController.sink;

  @override
  Stream<FlowState> get outputState =>
      _inputStreamController.stream.map((flowState) => flowState);

  void dispose() {
    _inputStreamController.close();
  }
}
abstract class BaseViewModelInputs {
  void start(); // start view model job
  void dispose(); // will be called when view model dies
  Sink get inputState;
}
abstract class BaseViewModelOuts {
// we will implement later
  Stream<FlowState> get outputState;
}
