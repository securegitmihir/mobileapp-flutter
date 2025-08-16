import 'package:auth_todo/core/error/failure.dart';
import 'package:auth_todo/core/usecases/interface/usecase_interface.dart';
import 'package:auth_todo/features/auth/domain/repository/interface/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class ValidateTokenUseCase implements UseCaseInterface<bool, NoParams> {
  final AuthRepository authRepository;

  ValidateTokenUseCase(this.authRepository);

  @override
  Future<Either<Failure, bool>> call(NoParams noParams) async {
    return await authRepository.checkLoggedIn();
  }
}
