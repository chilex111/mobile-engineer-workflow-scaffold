import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/user_profile_entity.dart';
import '../../domain/repositories/user_profile_repository.dart';
import '../datasources/user_profile_remote_datasource.dart';
import '../datasources/user_profile_local_datasource.dart';

/// Repository implementation: orchestrates remote and local datasources.
/// 
/// Caching strategy used here: cache-first with remote fallback.
/// - Try local cache first (fast, offline-safe)
/// - On cache miss, fetch from remote and cache the result
/// - On write, update remote then invalidate local cache
///
/// This decision is documented here so future maintainers
/// don't have to guess why the data flow works this way.
class UserProfileRepositoryImpl implements UserProfileRepository {
  const UserProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  final UserProfileRemoteDataSource remoteDataSource;
  final UserProfileLocalDataSource localDataSource;

  @override
  Future<Either<Failure, UserProfileEntity>> getProfile(String userId) async {
    // 1. Try local cache first
    final cached = await localDataSource.getCachedProfile(userId);
    if (cached != null) return Right(cached.toEntity());

    // 2. Cache miss — fetch from remote and cache the result
    try {
      final remote = await remoteDataSource.getProfile(userId);
      await localDataSource.cacheProfile(remote);
      return Right(remote.toEntity());
    } on Failure catch (f) {
      return Left(f);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserProfileEntity>> updateProfile({
    required String userId,
    required String displayName,
    required String bio,
  }) async {
    try {
      final updated = await remoteDataSource.updateProfile(
        userId: userId,
        displayName: displayName,
        bio: bio,
      );
      // Invalidate cache so next read gets fresh data
      await localDataSource.clearProfile(userId);
      await localDataSource.cacheProfile(updated);
      return Right(updated.toEntity());
    } on Failure catch (f) {
      return Left(f);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
