import 'package:firstproject/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:firstproject/domain/repository/repository.dart';
import 'package:firstproject/domain/usecase/base_use_case.dart';

class ForgotPasswordUseCase extends BaseUseCase {
  final Repository _repository;
  ForgotPasswordUseCase(this._repository);
  @override
  Future<Either<Failure, String>> excute(input) {
    return _repository.forgotPassword(input);
  }
}
