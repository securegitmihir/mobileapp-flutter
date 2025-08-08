import 'package:auth_todo/core/common/entities/user.dart';
import 'package:auth_todo/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signIn(String username, String password);
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, User>> signUp(String username, String password);
  Future<Either<Failure, bool>> checkLoggedIn();
}
