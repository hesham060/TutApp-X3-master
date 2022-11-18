import 'package:dio/dio.dart';
import 'package:firstproject/app/shared_prefs.dart';
import 'package:firstproject/data/data_source/remote_data_source.dart';
import 'package:firstproject/data/network/app_api.dart';
import 'package:firstproject/data/network/dio_factory.dart';
import 'package:firstproject/data/network/network_info.dart';
import 'package:firstproject/data/repository/repository_impl.dart';
import 'package:firstproject/domain/repository/repository.dart';
import 'package:firstproject/domain/usecase/forgot_password_use_case.dart';
import 'package:firstproject/domain/usecase/login_use_case.dart';
import 'package:firstproject/presentation/forgot_password/view_model/forgot_password_view_model.dart';
import 'package:firstproject/presentation/login_view/viewmodel/longin_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // app module, its a module where we put all generic dependencies

  // shared prefs instance
  final sharedPrefs = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // app prefs instance
  instance
      .registerLazySingleton<AppPrefreneces>(() => AppPrefreneces(instance()));

  // network info
  instance.registerLazySingleton<NetwokInfo>(
      () => NetworkingInfoImpl(InternetConnectionChecker()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  Dio? dio = await instance<DioFactory>().getDio();
  //app service client
  instance
      .registerLazySingleton<AppServiceClients>(() => AppServiceClients(dio!));

  // remote data source//
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoreDataSourceImpl(instance()));

  // repository

  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance()));
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}

initForgotPasswordModule() {
  if (!GetIt.I.isRegistered<ForgotPasswordUseCase>()) {
    instance.registerFactory<ForgotPasswordUseCase>(
        () => ForgotPasswordUseCase(instance()));
    instance.registerFactory<ForgotPasswordViewModel>(
        () => ForgotPasswordViewModel(instance()));
  }
}
