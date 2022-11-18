import 'package:firstproject/app/di.dart';
import 'package:firstproject/presentation/common/state_renderer_implementer.dart';
import 'package:firstproject/presentation/forgot_password/view_model/forgot_password_view_model.dart';
import 'package:firstproject/presentation/resources/assets_manager.dart';
import 'package:firstproject/presentation/resources/string_manager.dart';
import 'package:firstproject/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final ForgotPasswordViewModel _viewModel =
      instance<ForgotPasswordViewModel>();
  _bind() {
    _viewModel.start();
    _emailTextEditingController.addListener(
      () => _viewModel.setEmail(_emailTextEditingController.text),
    );
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<FlowState>(
      stream: _viewModel.outputState,
      builder: (context, snapshot) {
        return snapshot.data?.getScreenWidget(context, _getContentWidget(), () {
              _viewModel.forgetpassword();
            }) ??
            _getContentWidget();
      },
    ));
  }

  Widget _getContentWidget() {
    return Container(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image(image: AssetImage(ImageAssets.splashLogo)),
              const SizedBox(
                height: AppSize.s28,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: AppPadding.p28, left: AppPadding.p28),
                child: StreamBuilder<bool>(
                  stream: _viewModel.outPutIsAllInputValid,
                  builder: (context, snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailTextEditingController,
                      decoration: InputDecoration(
                        hintText: AppString.emailHint,
                        labelText: AppString.emailHint,
                        errorText: (snapshot.data ?? true)
                            ? null
                            : AppString.invalidEmail,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: AppSize.s28,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: AppPadding.p28, left: AppPadding.p28),
                child: StreamBuilder<bool>(
                  stream: _viewModel.outPutIsAllInputValid,
                  builder: (context, snapshot) {
                    return SizedBox(
                      width: double.infinity,
                      height: AppSize.s40,
                      child: ElevatedButton(
                        onPressed: (snapshot.data ?? false)
                            ? () => _viewModel.forgetpassword()
                            : null,
                        child: const Text(AppString.resetPassword),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
