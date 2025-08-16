import 'package:auth_todo/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UseCaseInterface<Response, Params> {
  Future<Either<Failure, Response>> call(Params params);
}

class NoParams {}
