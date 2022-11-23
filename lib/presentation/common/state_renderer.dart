import 'package:firstproject/presentation/resources/assets_manager.dart';
import 'package:firstproject/presentation/resources/color_manager.dart';
import 'package:firstproject/presentation/resources/fonts_manager.dart';
import 'package:firstproject/presentation/resources/string_manager.dart';
import 'package:firstproject/presentation/resources/styles_manager.dart';
import 'package:firstproject/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

enum StateRendererType {
  // POPUP STATES (DIALOG)
  popupLoadingState,
  popupErrorState,

  // FULL SCREEN STATED (FULL SCREEN)
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,
  // general
  contentState,
  popupSuccess,
}

class StateRenderer extends StatelessWidget {
  StateRendererType stateRendererType;
  String message;
  String title;
  Function retryActionFunction;
  StateRenderer(
      {super.key,
      required this.stateRendererType,
      this.message = AppString.loading,
      this.title = "",
      required this.retryActionFunction});

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.popupLoadingState:
        return _getPopupDiolog(
          context,
          [
            _getAnimatedImage(JsonAssets.loading),
          ],
        );
      case StateRendererType.popupErrorState:
        return _getPopupDiolog(context, [
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message),
          _getRetryButton(AppString.ok, context),
        ]);
      case StateRendererType.fullScreenLoadingState:
        return _getItemColumn([
          _getAnimatedImage(JsonAssets.loading),
          _getMessage(message),
        ]);
      case StateRendererType.fullScreenErrorState:
        return _getItemColumn([
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message),
          _getRetryButton(AppString.retryAgain, context),
        ]);
      case StateRendererType.fullScreenEmptyState:
        return _getItemColumn([
          _getAnimatedImage(JsonAssets.empty),
          _getMessage(message),
        ]);
      case StateRendererType.contentState:
        return Container();
      case StateRendererType.popupSuccess:
        return _getItemColumn([
          _getAnimatedImage(JsonAssets.success),
          _getMessage(title),
          _getMessage(message),
          _getRetryButton(AppString.ok, context),
        ]);
      default:
        return Container();
    }
  }

  Widget _getPopupDiolog(BuildContext context, List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s14)),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        color: ColorManager.white,
        // decoration: BoxDecoration(

        //   shape: BoxShape.rectangle,
        //   borderRadius: BorderRadius.circular(AppSize.s14),
        //   boxShadow: const [
        //     BoxShadow(
        //       color: Colors.black26,
        //     ),
        //   ],
        // ),
        child: _getDialogContent(context, children),
      ),
    );
  }

  Widget _getDialogContent(BuildContext context, List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getItemColumn(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  // to get animation image
  Widget _getAnimatedImage(String animatinName) {
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Lottie.asset(animatinName),
    );
  }

  Widget _getMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Text(
          message,
          style:
              getReglarStyle(color: ColorManager.black, fontSize: FontSize.s18),
              textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _getRetryButton(String buttonTitle, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (stateRendererType == StateRendererType.fullScreenErrorState) {
                // call retry function
                retryActionFunction.call();
              } else {
                // popup error state
                Navigator.of(context).pop();
              }
            },
            child: Text(buttonTitle),
          ),
        ),
      ),
    );
  }
}
