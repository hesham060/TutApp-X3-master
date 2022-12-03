import 'package:firstproject/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:firstproject/data/network/requests.dart';
import 'package:firstproject/domain/models/models.dart';
import 'package:firstproject/domain/repository/repository.dart';
import 'package:firstproject/domain/usecase/base_use_case.dart';

class RegisterUseCase
    implements BaseUseCase<RegisterUseCaseInput, Authentication> {
  // here we using Repositry class by creating variable _repositry
  final Repository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> excute(input) async {
    return await _repository.register(RegisterRequest(
        input.userName,
        input.countryMobileCode,
        input.mobileNumber,
        input.email,
        input.password,
        input.profilePicture));
  }
}

class RegisterUseCaseInput {
  String userName;
  String countryMobileCode;
  String mobileNumber;
  String email;
  String password;
  String profilePicture;
  RegisterUseCaseInput(this.userName, this.countryMobileCode, this.mobileNumber,
      this.email, this.password, this.profilePicture);
}
