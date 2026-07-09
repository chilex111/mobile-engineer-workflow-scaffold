import 'package:hive_flutter/hive_flutter.dart';
import '../models/user_profile_model.dart';

/// Local DataSource: caches profile data in Hive.
/// Only responsibility is reading/writing the local store.
abstract interface class UserProfileLocalDataSource {
  Future<UserProfileModel?> getCachedProfile(String userId);
  Future<void> cacheProfile(UserProfileModel profile);
  Future<void> clearProfile(String userId);
}

class UserProfileLocalDataSourceImpl implements UserProfileLocalDataSource {
  static const _boxName = 'user_profiles';

  Future<Box<Map>> get _box async => Hive.openBox<Map>(_boxName);

  @override
  Future<UserProfileModel?> getCachedProfile(String userId) async {
    final box = await _box;
    final data = box.get(userId);
    if (data == null) return null;
    return UserProfileModel.fromJson(Map<String, dynamic>.from(data));
  }

  @override
  Future<void> cacheProfile(UserProfileModel profile) async {
    final box = await _box;
    await box.put(profile.id, profile.toJson());
  }

  @override
  Future<void> clearProfile(String userId) async {
    final box = await _box;
    await box.delete(userId);
  }
}
