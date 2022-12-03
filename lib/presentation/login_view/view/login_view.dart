import 'package:firstproject/presentation/login_view/viewmodel/longin_viewmodel.dart';
import 'package:firstproject/presentation/resources/color_manager.dart';
import 'package:firstproject/presentation/resources/string_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../../app/di.dart';
import '../../../app/shared_prefs.dart';
import '../../common/state_renderer_implementer.dart';
import '../../resources/assets_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/values_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel = instance<LoginViewModel>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AppPrefreneces _appPrefreneces = instance<AppPrefreneces>();

  _bind() {
    // here we start
    _viewModel.start();
    _userNameController
        .addListener(() => _viewModel.setUserName(_userNameController.text));

    _userPasswordController.addListener(
        () => _viewModel.setPassword(_userPasswordController.text));
    _viewModel.isUserLoggedInSucessfullyStreamController.stream
        .listen((isLoggedIn) {
      if (isLoggedIn) {
        // navigate to main screen
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _appPrefreneces.setUserLoggedIn();
          Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
        });
      }
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                  () {
                _viewModel.login();
              }) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return Container(
      padding: const EdgeInsets.only(top: AppPadding.p100),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(
                child: Image(
                  image: AssetImage(
                    ImageAssets.splashLogo,
                  ),
                ),
              ),
              const SizedBox(
                height: AppSize.s28,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppSize.s28, right: AppSize.s28),
                child: StreamBuilder<bool>(
                  stream: _viewModel.outIsUserNameValid,
                  builder: (context, snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _userNameController,
                      decoration: InputDecoration(
                        hintText: AppString.userNameError,
                        labelText: AppString.userNameError,
                        errorText: (snapshot.data ?? true)
                            ? null
                            : AppString.userNameError,
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
                    left: AppSize.s28, right: AppSize.s28),
                child: StreamBuilder<bool>(
                  stream: _viewModel.outIsPasswordValid,
                  builder: (context, snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: _userPasswordController,
                      decoration: InputDecoration(
                        hintText: AppString.passwordError,
                        labelText: AppString.passwordError,
                        errorText: (snapshot.data ?? true)
                            ? null
                            : AppString.passwordError,
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
                    left: AppSize.s28, right: AppSize.s28),
                child: StreamBuilder<bool>(
                    stream: _viewModel.outAreAllInputsValid,
                    builder: (context, snapshot) {
                      return SizedBox(
                        width: double.infinity,
                        height: AppSize.s40,
                        child: ElevatedButton(
                          onPressed: (snapshot.data ?? false)
                              ? () {
                                  _viewModel.login();
                                }
                              : null,
                          child: const Text(AppString.login),
                        ),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: AppPadding.p8,
                    left: AppPadding.p20,
                    right: AppPadding.p20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, Routes.forgetPasswordRoute);
                      },
                      child: Text(
                        AppString.forgetPassword,
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.registerRoute);
                      },
                      child: Text(
                        AppString.registerText,
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
