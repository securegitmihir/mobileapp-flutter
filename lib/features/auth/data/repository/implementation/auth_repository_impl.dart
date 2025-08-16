import 'dart:convert';

import 'package:auth_todo/core/common/entities/user.dart';
import 'package:auth_todo/core/error/failure.dart';
import 'package:auth_todo/features/auth/data/model/user_model.dart';
import 'package:auth_todo/features/auth/data/provider/interface/auth_api_provider.dart';
import 'package:auth_todo/features/auth/data/provider/interface/auth_local_provider.dart';
import 'package:auth_todo/features/auth/domain/repository/interface/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiProvider _authApiProvider;
  final AuthLocalProvider _authLocalStorageProvider;

  AuthRepositoryImpl(this._authApiProvider, this._authLocalStorageProvider);

  @override
  Future<Either<Failure, User>> signIn(String username, String password) async {
    try {
      final user = await _authApiProvider.signIn(username, password);
      // Save user token to local storage
      await _authLocalStorageProvider.storeUpdatedUserInfo(
        jsonEncode(user.toJson()),
      );
      return Right(user);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signUp(String username, String password) async {
    try {
      final user = await _authApiProvider.signUp(username, password);
      // Save user token to local storage
      await _authLocalStorageProvider.storeUpdatedUserInfo(
        jsonEncode(user.toJson()),
      );
      return Right(user);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> checkLoggedIn() async {
    try {
      final storedData = await _authLocalStorageProvider.checkLoggedIn();
      if (storedData == null || storedData.isEmpty) {
        return Left(Failure(''));
      }
      UserModel userModel = UserModel.fromJson(jsonDecode(storedData));
      final token = userModel.token;
      if (token == null || token.isEmpty) {
        return Left(Failure(''));
      }
      return Right(true);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _authLocalStorageProvider.signOut();
      return Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
