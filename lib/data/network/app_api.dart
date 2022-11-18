import 'package:dio/dio.dart';
import 'package:firstproject/app/constants.dart';
import 'package:firstproject/data/response/responses.dart';
import 'package:retrofit/http.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClients {
  factory AppServiceClients(Dio dio, {String baseUrl}) = _AppServiceClients;

  // this implementation post request
  @POST("/customers/login")
  Future<AuthenticationResponse> login(
    @Field("email") String email,
    @Field("password") String password,
  );
  // this implementation post request for password
 @POST("/customers/forgetPassword")
  Future<ForgotPasswordResponse> forgotPassword(@Field("email") String email);

}
