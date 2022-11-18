import 'package:dartz/dartz.dart';
import 'package:firstproject/data/network/failure.dart';
import 'package:firstproject/data/network/requests.dart';
import 'package:firstproject/domain/models/models.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
  Future<Either<Failure,String>> forgotPassword(String email);

}
