import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../entities/user_profile_entity.dart';

/// Abstract interface — the ViewModel/Provider depends on this,
/// not on the concrete implementation.
/// This makes the repository independently testable and swappable.
abstract interface class UserProfileRepository {
  /// Fetch the current user's profile.
  /// Returns Either: Left = failure, Right = profile data.
  Future<Either<Failure, UserProfileEntity>> getProfile(String userId);

  /// Update the current user's display name and bio.
  Future<Either<Failure, UserProfileEntity>> updateProfile({
    required String userId,
    required String displayName,
    required String bio,
  });
}
