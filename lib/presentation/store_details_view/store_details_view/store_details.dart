import 'dart:async';

import 'package:firstproject/app/di.dart';
import 'package:firstproject/presentation/common/state_renderer_implementer.dart';
import 'package:firstproject/presentation/store_details_view/store_details_viewModel/store_details_viewModel.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/models.dart';
import '../../resources/color_manager.dart';
import '../../resources/string_manager.dart';
import '../../resources/values_manager.dart';

class StoreDetailsView extends StatefulWidget {
  const StoreDetailsView({Key? key}) : super(key: key);

  @override
  State<StoreDetailsView> createState() => _StoreDetailsViewState();
}

class _StoreDetailsViewState extends State<StoreDetailsView> {
  final StoreDetailsViewModel _viewModel = instance<StoreDetailsViewModel>();
  @override
  void initState() {
    _bind();
    super.initState();
  }

  _bind() {
    _viewModel.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<FlowState>(
      stream: _viewModel.outputState,
      builder: (context, snapshot) {
        return Container(
          child:
              snapshot.data?.getScreenWidget(context, _getContentWidget(), () {
                    _viewModel.start();
                  }) ??
                  Container(),
        );
      },
    ));
  }

 Widget _getContentWidget() {
    return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: AppBar(
          title: const Text(AppString.storeDetails),
          elevation: AppSize.s0,
          iconTheme: IconThemeData(
            //back button
            color: ColorManager.white,
          ),
          backgroundColor: ColorManager.primary,
          centerTitle: true,
        ),
        body: Container(
          constraints: const BoxConstraints.expand(),
          color: ColorManager.white,
          child: SingleChildScrollView(
            child: StreamBuilder<StoreDetails>(
              stream: _viewModel.outPutStoreDetails,
              builder: (context, snapshot) {
                return _getItems(snapshot.data);
              },
            ),
          ),
        ));
  }
  Widget _getItems(StoreDetails? storeDetails) {
    if (storeDetails != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Image.network(
            storeDetails.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 250,
          )),
          _getSection(AppString.details),
          _getInfoText(storeDetails.details),
          _getSection(AppString.services),
          _getInfoText(storeDetails.services),
          _getSection(AppString.about),
          _getInfoText(storeDetails.about)
        ],
      );
    } else {
      return Container();
    }
  }
  Widget _getSection(String title) {
    return Padding(
        padding: const EdgeInsets.only(
            top: AppPadding.p12,
            left: AppPadding.p12,
            right: AppPadding.p12,
            bottom: AppPadding.p2),
        child: Text(title, style: Theme.of(context).textTheme.titleMedium));
  }

  Widget _getInfoText(String info) {
    return Padding(
      padding: const EdgeInsets.all(AppSize.s12),
      child: Text(info, style: Theme.of(context).textTheme.bodySmall),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
