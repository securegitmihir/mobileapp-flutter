import 'package:auth_todo/core/common/entities/user.dart';
import 'package:auth_todo/core/error/failure.dart';
import 'package:auth_todo/core/usecases/usecase.dart';
import 'package:auth_todo/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements UseCase<User, UserSignUpParams> {
  final AuthRepository authRepository;

  UserSignUp(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return await authRepository.signUp(params.username, params.password);
  }
}

class UserSignUpParams {
  final String username;
  final String password;

  UserSignUpParams({required this.username, required this.password});
}
