import 'package:auth_todo/core/usecases/usecase_interface.dart';
import 'package:auth_todo/features/auth/domain/usecases/implementation/user_sign_in_use_case.dart';
import 'package:auth_todo/features/auth/domain/usecases/implementation/user_sign_out_use_case.dart';
import 'package:auth_todo/features/auth/domain/usecases/implementation/user_sign_up_use_case.dart';
import 'package:auth_todo/features/auth/domain/usecases/implementation/validate_token_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignInUseCase _userSignInUseCase;
  final UserSignUpUseCase _userSignUpUseCase;
  final ValidateTokenUseCase _validateTokenUseCase;
  final UserSignOutUseCase _userSignOutUseCase;

  AuthBloc(
    this._userSignInUseCase,
    this._userSignUpUseCase,
    this._validateTokenUseCase,
    this._userSignOutUseCase,
  ) : super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
    on<AuthCheckLoggedIn>(_onAuthCheckLoggedIn);
    on<AuthSignOut>(_onAuthSignOut);
    on<AuthResetForm>((event, emit) {
      emit(AuthInitial());
    });
  }
  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await _userSignUpUseCase(
      UserSignUpParams(username: event.username, password: event.password),
    ).then((result) {
      result.fold(
        (failure) => emit(AuthFailure(failure.message)),
        (user) => emit(AuthSuccess()),
      );
    });
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await _userSignInUseCase(
      UserSignInParams(username: event.username, password: event.password),
    ).then((result) {
      result.fold(
        (failure) => emit(AuthFailure(failure.message)),
        (user) => emit(AuthSuccess()),
      );
    });
  }

  void _onAuthCheckLoggedIn(
    AuthCheckLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    await _validateTokenUseCase(NoParams()).then((result) {
      result.fold((failure) => emit(AuthFailure(failure.message)), (isValid) {
        if (isValid) {
          emit(AuthSuccess());
        } else {
          emit(AuthNoToken());
        }
      });
    });
  }

  void _onAuthSignOut(event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await _userSignOutUseCase(NoParams()).then((result) {
      result.fold(
        (failure) => emit(AuthFailure(failure.message)),
        (_) => emit(AuthInitial()),
      );
    });
  }
}
