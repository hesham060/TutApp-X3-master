import 'dart:async';
import 'package:firstproject/domain/usecase/forgot_password_use_case.dart';
import 'package:firstproject/presentation/base/base_view_model.dart';
import 'package:firstproject/presentation/common/state_renderer.dart';
import 'package:firstproject/presentation/common/state_renderer_implementer.dart';

import '../../../app/functions.dart';

class ForgotPasswordViewModel extends BaseViewModel
    with ForgotPasswordViewModelInput, ForgotPasswordViewModelOut {
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController _isAllInputValidStreamController =
      StreamController<void>.broadcast();

  final ForgotPasswordUseCase _forgotPasswordUseCase;

  ForgotPasswordViewModel(this._forgotPasswordUseCase);
  var email = "";

  @override
  void start() {
    // to check data which we put it in field
    inputState.add(ContentState());
  }

  @override
  forgetpassword() async {
    // here we add loading state
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    // here  we direct right or left according data
    (await _forgotPasswordUseCase.excute(email)).fold((Failure) {
      inputState
          .add(ErrorState(StateRendererType.popupErrorState, Failure.message));
    },
        // here right it means bring data
        (supportMessage) {
      inputState.add(SuccessState(supportMessage));
    });
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    this.email = email;
    _validate;
  }

  @override
  Sink get inputEmail => _emailStreamController;

  @override
  Sink get inputIsAllInputValid => _isAllInputValidStreamController;
  void dispose() {
    _emailStreamController.close();
    _isAllInputValidStreamController.close();
  }

  @override
  Stream<bool> get outPutIsAllInputValid =>
      _emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<bool> get outPutIsEmailValid => _isAllInputValidStreamController.stream
      .map((isEmailAllinvalid) => _isEmailAllinvalid());

  _isEmailAllinvalid() {
    return inputIsAllInputValid.add(null);
  }

  _validate() {
    inputIsAllInputValid.add(null);
  }
}

abstract class ForgotPasswordViewModelInput {
  forgetpassword();
  setEmail(String email);
  Sink get inputEmail;
  Sink get inputIsAllInputValid;
}

abstract class ForgotPasswordViewModelOut {
  Stream<bool> get outPutIsEmailValid;
  Stream<bool> get outPutIsAllInputValid;
}
