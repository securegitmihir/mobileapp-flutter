import 'package:auth_todo/core/constants/constants.dart';
import 'package:auth_todo/core/services/http/interface/api_client.dart';
import 'package:auth_todo/core/services/http/implementation/api_client_impl.dart';
import 'package:auth_todo/core/services/storage/interface/local_storage_service.dart';
import 'package:auth_todo/core/services/storage/implementation/local_storage_service_impl.dart';
import 'package:auth_todo/features/auth/data/provider/interface/auth_api_provider.dart';
import 'package:auth_todo/features/auth/data/provider/implementation/auth_api_provider_impl.dart';
import 'package:auth_todo/features/auth/data/provider/interface/auth_local_provider.dart';
import 'package:auth_todo/features/auth/data/provider/implementation/auth_local_provider_impl.dart';
import 'package:auth_todo/features/auth/data/repository/implementation/auth_repository_impl.dart';
import 'package:auth_todo/features/auth/domain/repository/interface/auth_repository.dart';
import 'package:auth_todo/features/auth/domain/usecases/implementation/user_sign_in_use_case.dart';
import 'package:auth_todo/features/auth/domain/usecases/implementation/user_sign_out_use_case.dart';
import 'package:auth_todo/features/auth/domain/usecases/implementation/user_sign_up_use_case.dart';
import 'package:auth_todo/features/auth/domain/usecases/implementation/validate_token_use_case.dart';
import 'package:auth_todo/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:auth_todo/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:get_it/get_it.dart';
import "package:hive_flutter/hive_flutter.dart";

final serviceLocator = GetIt.instance;

Future<Box> _initializeHiveBox() async {
  if (!Hive.isBoxOpen('app_box')) {
    return await Hive.openBox('app_box');
  }
  return Hive.box('app_box');
}

Future<void> initDependencies() async {
  await Hive.initFlutter();

  final hiveBox = await _initializeHiveBox();
  serviceLocator.registerLazySingleton(() => hiveBox);

  serviceLocator.registerLazySingleton<LocalStorageService>(
    () => HiveStorageServiceImpl(serviceLocator()),
  );

  serviceLocator.registerFactory<ApiClient>(
    () => ApiClientImpl(baseUrl: ApiUrls.baseUrl),
  );

  serviceLocator.registerFactory<AuthApiProvider>(
    () => AuthApiProviderImpl(serviceLocator()),
  );

  serviceLocator.registerFactory<AuthLocalProvider>(
    () => AuthLocalProviderImpl(serviceLocator()),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator(), serviceLocator()),
  );

  serviceLocator.registerFactory(() => ValidateTokenUseCase(serviceLocator()));
  serviceLocator.registerFactory(() => UserSignInUseCase(serviceLocator()));
  serviceLocator.registerFactory(() => UserSignOutUseCase(serviceLocator()));
  serviceLocator.registerFactory(() => UserSignUpUseCase(serviceLocator()));

  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(() => TodoBloc());
}
