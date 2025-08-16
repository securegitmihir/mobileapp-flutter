import 'package:auth_todo/core/error/failure.dart';
import 'package:auth_todo/core/usecases/interface/usecase_interface.dart';
import 'package:auth_todo/features/auth/domain/repository/interface/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignOutUseCase implements UseCaseInterface<void, NoParams> {
  final AuthRepository authRepository;

  UserSignOutUseCase(this.authRepository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await authRepository.signOut();
  }
}
