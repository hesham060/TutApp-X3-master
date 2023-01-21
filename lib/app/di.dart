import 'package:dio/dio.dart';
import 'package:firstproject/app/shared_prefs.dart';
import 'package:firstproject/data/data_source/local_data_source.dart';
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
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/usecase/home_use_case.dart';
import '../domain/usecase/register_use_case.dart';
import '../domain/usecase/store_details_usecase.dart';
import '../presentation/main/pages/home/viewmodel/home_viewmodel.dart';
import '../presentation/register/register_viewmodel/register_viewmodel.dart';
import '../presentation/store_details_view/store_details_viewModel/store_details_viewModel.dart';

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
      () => RemoteDataSourceImpl(instance()));
  // local data source//
  instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());
  // repository
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance(), instance()));
 
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

initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance
        .registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
    instance.registerFactory<RegisterViewModel>(
        () => RegisterViewModel(instance()));
    instance.registerFactory<ImagePicker>(() => ImagePicker());
  }
}

initHomeModule() {
  if (!GetIt.I.isRegistered<HomeUseCase>()) {
    instance.registerFactory<HomeUseCase>(() => HomeUseCase(instance()));
    instance.registerFactory<HomeViewModel>(() => HomeViewModel(instance()));
  }
  initStoreDetailsModule() {
    if (!GetIt.I.isRegistered<StoreDetailsUseCase>()) {
      instance.registerFactory<StoreDetailsUseCase>(
        () => StoreDetailsUseCase(
          instance(),
        ),
      );
      instance.registerFactory<StoreDetailsViewModel>(
          () => StoreDetailsViewModel(instance()));
    }
  }
}
