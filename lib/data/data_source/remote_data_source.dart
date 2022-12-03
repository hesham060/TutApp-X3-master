// this is implement it to call appServiceClient
import 'package:firstproject/data/network/app_api.dart';
import 'package:firstproject/data/network/requests.dart';
import 'package:firstproject/data/response/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<ForgotPasswordResponse> forgotPassword(String email);
  Future<AuthenticationResponse> register(RegisterRequest registerRequest);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClients _appServiceClient;
  RemoteDataSourceImpl(this._appServiceClient);

  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
        loginRequest.email, loginRequest.password);
  }

  Future<ForgotPasswordResponse> forgotPassword(String email) async {
    return await _appServiceClient.forgotPassword(email);
  }

  @override
  Future<AuthenticationResponse> register(RegisterRequest registerRequest) {
    return _appServiceClient.register(
        registerRequest.userName,
        registerRequest.countryMobileCode,
        registerRequest.mobileNumber,
        registerRequest.email,
        registerRequest.password,
        registerRequest.profilePic);
  }
}
