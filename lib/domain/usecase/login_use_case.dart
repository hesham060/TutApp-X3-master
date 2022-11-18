import 'package:firstproject/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:firstproject/data/network/requests.dart';
import 'package:firstproject/domain/models/models.dart';
import 'package:firstproject/domain/repository/repository.dart';
import 'package:firstproject/domain/usecase/base_use_case.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  // here we using Repositry class by creating variable _repositry
  final Repository _repository;

  LoginUseCase(this._repository);
  
  @override
  Future<Either<Failure, Authentication>> excute(input) async {
    return await _repository.login(LoginRequest(input.email, input.password));


  }

}

class LoginUseCaseInput {
  String email;
  String password;
  LoginUseCaseInput(this.email, this.password);
}
