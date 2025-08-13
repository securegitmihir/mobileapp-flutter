import 'package:auth_todo/core/constants/constants.dart';
import 'package:auth_todo/core/services/storage/interface/local_storage_service.dart';
import 'package:auth_todo/features/auth/data/provider/interface/auth_local_provider.dart';

class AuthLocalProviderImpl implements AuthLocalProvider {
  final LocalStorageService _storageService;
  AuthLocalProviderImpl(this._storageService);
  @override
  Future<void> signOut() async {
    try {
      await _storageService.clear();
    } catch (e) {
      throw Exception('Failed to sign out: ${e.toString()}');
    }
  }

  @override
  Future<String?> checkLoggedIn() async {
    try {
      final value = await _storageService.read(StorageKeys.authUserKey);
      return value;
    } catch (e) {
      throw Exception('Failed to check local storage: ${e.toString()}');
    }
  }

  @override
  Future<void> storeUpdatedUserInfo(String value) async {
    try {
      await _storageService.save(StorageKeys.authUserKey, value);
    } catch (e) {
      throw Exception('Failed to store user info: ${e.toString()}');
    }
  }
}
