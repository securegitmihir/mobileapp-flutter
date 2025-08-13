import 'package:auth_todo/core/services/storage/interface/local_storage_service.dart';
import 'package:hive/hive.dart';

class HiveStorageServiceImpl implements LocalStorageService {
  final Box _box;

  HiveStorageServiceImpl(this._box);

  @override
  Future<void> save(String key, String value) async {
    await _box.put(key, value);
  }

  @override
  Future<String?> read(String key) async {
    return _box.get(key);
  }

  @override
  Future<void> delete(String key) async {
    await _box.delete(key);
  }

  @override
  Future<void> clear() async {
    await _box.clear();
  }
}
