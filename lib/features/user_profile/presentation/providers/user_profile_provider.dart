import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fpdart/fpdart.dart';
import '../../domain/entities/user_profile_entity.dart';
import '../../domain/repositories/user_profile_repository.dart';
import '../../data/repositories/user_profile_repository_impl.dart';
import '../../data/datasources/user_profile_remote_datasource.dart';
import '../../data/datasources/user_profile_local_datasource.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/error/failure.dart';

part 'user_profile_provider.g.dart';

// ── Repository provider ──────────────────────────────────────────────────────

@riverpod
UserProfileRepository userProfileRepository(UserProfileRepositoryRef ref) {
  return UserProfileRepositoryImpl(
    remoteDataSource: UserProfileRemoteDataSourceImpl(ref.watch(dioProvider)),
    localDataSource: UserProfileLocalDataSourceImpl(),
  );
}

// ── State: fetch profile ─────────────────────────────────────────────────────
//
// Uses AsyncNotifierProvider — gives the UI three states automatically:
//   loading  → show a spinner
//   error    → show an error message
//   data     → show the profile
//
// The UI never manages isLoading booleans manually.

@riverpod
class UserProfile extends _\$UserProfile {
  // Hardcoded for the scaffold — replace with your auth provider
  static const _userId = 'user_001';

  @override
  Future<UserProfileEntity> build() async {
    final result = await ref
        .watch(userProfileRepositoryProvider)
        .getProfile(_userId);

    return result.getOrElse((failure) => throw Exception(failure.message));
  }

  /// Update display name and bio.
  /// On success, refreshes the provider so the UI reflects the new data.
  Future<void> updateProfile({
    required String displayName,
    required String bio,
  }) async {
    final result = await ref
        .read(userProfileRepositoryProvider)
        .updateProfile(userId: _userId, displayName: displayName, bio: bio);

    result.fold(
      (failure) => state = AsyncError(Exception(failure.message), StackTrace.current),
      (updated) => state = AsyncData(updated),
    );
  }
}
