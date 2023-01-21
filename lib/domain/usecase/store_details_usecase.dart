import 'package:firstproject/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:firstproject/domain/repository/repository.dart';
import 'package:firstproject/domain/usecase/base_use_case.dart';

import '../models/models.dart';

class StoreDetailsUseCase extends BaseUseCase<void, StoreDetails> {
  Repository repository;
  StoreDetailsUseCase(this.repository);
  @override
  Future<Either<Failure, StoreDetails>> excute(void input) {
    return repository.getStoreDetails();
  }
}
