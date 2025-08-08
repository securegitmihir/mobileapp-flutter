import 'package:auth_todo/core/error/failure.dart';
import 'package:auth_todo/core/usecases/usecase.dart';
import 'package:auth_todo/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class ValidateToken implements UseCase<bool, NoParams> {
  final AuthRepository authRepository;

  ValidateToken(this.authRepository);

  @override
  Future<Either<Failure, bool>> call(NoParams noParams) async {
    return await authRepository.checkLoggedIn();
  }
}
