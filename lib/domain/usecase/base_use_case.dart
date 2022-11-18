import 'package:dartz/dartz.dart';
import 'package:firstproject/data/network/failure.dart';

abstract class BaseUseCase<In, Out>{
Future<Either<Failure,Out>> excute(In input);



}