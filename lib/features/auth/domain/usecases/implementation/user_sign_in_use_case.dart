import 'package:auth_todo/core/common/entities/user.dart';
import 'package:auth_todo/core/error/failure.dart';
import 'package:auth_todo/core/usecases/interface/usecase_interface.dart';
import 'package:auth_todo/features/auth/domain/repository/interface/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignInUseCase implements UseCaseInterface<User, UserSignInParams> {
  final AuthRepository authRepository;

  UserSignInUseCase(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignInParams params) async {
    return await authRepository.signIn(params.username, params.password);
  }
}

class UserSignInParams {
  final String username;
  final String password;

  UserSignInParams({required this.username, required this.password});
}
