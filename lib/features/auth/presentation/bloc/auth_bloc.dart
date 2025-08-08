import 'package:auth_todo/core/usecases/usecase.dart';
import 'package:auth_todo/features/auth/domain/usecases/user_sign_in.dart';
import 'package:auth_todo/features/auth/domain/usecases/user_sign_out.dart';
import 'package:auth_todo/features/auth/domain/usecases/user_sign_up.dart';
import 'package:auth_todo/features/auth/domain/usecases/validate_token.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignIn _userSignIn;
  final UserSignUp _userSignUp;
  final ValidateToken _validateToken;
  final UserSignOut _userSignOut;

  AuthBloc(
    this._userSignIn,
    this._userSignUp,
    this._validateToken,
    this._userSignOut,
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
    await _userSignUp(
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
    await _userSignIn(
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
    await _validateToken(NoParams()).then((result) {
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
    await _userSignOut(NoParams()).then((result) {
      result.fold(
        (failure) => emit(AuthFailure(failure.message)),
        (_) => emit(AuthInitial()),
      );
    });
  }
}
