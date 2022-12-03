// this file built from Repository, network check internet, Failure...
import 'package:firstproject/data/data_source/remote_data_source.dart';
import 'package:firstproject/data/mappers/mappers.dart';
import 'package:firstproject/data/network/error_handler.dart';
import 'package:firstproject/data/network/network_info.dart';
import 'package:firstproject/domain/models/models.dart';
import 'package:firstproject/data/network/requests.dart';
import 'package:firstproject/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:firstproject/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  // RepositoryImpl is comming from repository which define right or left
  final RemoteDataSource _remoteDataSource; // processed to login request
  final NetwokInfo _netwokInfo; // this is resposable for checking connection
  RepositoryImpl(this._remoteDataSource, this._netwokInfo);
  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _netwokInfo.isConnected) {
      // its connected , so its safe to call from api

      try {
        final response = await _remoteDataSource.login(loginRequest);
        if (response.status == ApiInternalStatus.success) {
          // sucess
          // return either right
          // return data
          return right(response.toDomain());
        } else {
          // failure --  return  business error coming from api
          // return either left
          return left(
            Failure(ApiInternalStatus.failure,
                response.message ?? ResponseMessage.DEFAULT),
          );
        }
      } catch (error) {
        return left(ErrorHandler.handler(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return left(
        Failure(Responsecode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION),
      );
    }
  }

  @override
  Future<Either<Failure, String>> forgotPassword(String email) async {
    if (await _netwokInfo.isConnected) {
      try {
        // its safe call
        final response = await _remoteDataSource.forgotPassword(email);

        if (response.status == ApiInternalStatus.success) {
          // sucess
          // return right
          return right(
            response.toDomain(),
          );
        } else {
          // failure
          // return left
          return Left(Failure(response.status ?? Responsecode.DEFAULT,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return left(ErrorHandler.handler(error).failure);
      }
    } else {
      return left(
        DataSource.NO_INTERNET_CONNECTION.getFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest) async {
    if (await _netwokInfo.isConnected) {
      // its connected , so its safe to call from api

      try {
        final response = await _remoteDataSource.register(registerRequest);
        if (response.status == ApiInternalStatus.success) {
          // sucess
          // return either right
          // return data
          return right(response.toDomain());
        } else {
          // failure --  return  business error coming from api
          // return either left
          return left(
            Failure(ApiInternalStatus.failure,
                response.message ?? ResponseMessage.DEFAULT),
          );
        }
      } catch (error) {
        return left(ErrorHandler.handler(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return left(
        Failure(Responsecode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION),
      );
    }
  }
}
