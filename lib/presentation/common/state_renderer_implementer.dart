import 'package:firstproject/app/constants.dart';
import 'package:firstproject/presentation/common/state_renderer.dart';
import 'package:firstproject/presentation/resources/string_manager.dart';
import 'package:flutter/material.dart';

// this one will communicate with view and state renderer
abstract class FlowState {
  StateRendererType getstateRendererType();

  String getMessage();
}

// Loading state (pop up, fullScreen )
class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String? message;
  LoadingState(
      {required this.stateRendererType, this.message = AppString.loading});

  @override
  String getMessage() => message = AppString.loading;

  @override
  StateRendererType getstateRendererType() => stateRendererType;
}

class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;
  ErrorState(this.stateRendererType, this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getstateRendererType() => stateRendererType;
}

class ContentState extends FlowState {
  ContentState();
  @override
  String getMessage() => Constants.empty;

  @override
  StateRendererType getstateRendererType() => StateRendererType.contentState;
}

// empty state
class EmptyState extends FlowState {
  String message;

  EmptyState(this.message);
  @override
  String getMessage() => message;

  @override
  StateRendererType getstateRendererType() =>
      StateRendererType.fullScreenEmptyState;
}

class SuccessState extends FlowState {
  String message;
  SuccessState(this.message);
  @override
  String getMessage() => message;

  @override
  StateRendererType getstateRendererType() => StateRendererType.popupSuccess;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (runtimeType) {
      case LoadingState:
        {
          if (getstateRendererType() == StateRendererType.popupLoadingState) {
            // show pop up screen
            showPopup(context, getstateRendererType(), getMessage());
            // show content ui of the screen
            return contentScreenWidget;
          } else {
            return StateRenderer(
                stateRendererType: getstateRendererType(),
                message: getMessage(),
                retryActionFunction: retryActionFunction);
          }
        }
      case ErrorState:
        {
          dismissDialog(context);
          if (getstateRendererType() == StateRendererType.popupErrorState) {
            // show pop up error
            showPopup(context, getstateRendererType(), getMessage());
            // show content ui of the screen
            return contentScreenWidget;
          } else {
            return StateRenderer(
                stateRendererType: getstateRendererType(),
                message: getMessage(),
                retryActionFunction: retryActionFunction);
          }
        }
      case EmptyState:
        {
          return StateRenderer(
              stateRendererType: getstateRendererType(),
              message: getMessage(),
              retryActionFunction: () {});
        }
      case ContentState:
        {
          dismissDialog(context);
          return contentScreenWidget;
        }
      case SuccessState:
        {
          // to remove loading screen 
          dismissDialog(context);
          // to show pop up sucess 
          showPopup(
              context, StateRendererType.popupSuccess, getMessage());
              // back to content widget 

               return contentScreenWidget;
        }

      default:
        {
          dismissDialog(context);
          return contentScreenWidget;
        }
    }
  }

  _isCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;
  dismissDialog(BuildContext context) {
    if (_isCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  showPopup(BuildContext context, StateRendererType stateRendererType,
      String message,{String title = Constants.empty}) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => showDialog(
        context: context,
        builder: (BuildContext context) => StateRenderer(
          stateRendererType: stateRendererType,
          message: message,
          retryActionFunction: () {},
          title: title,
        ),
      ),
    );
  }
}
