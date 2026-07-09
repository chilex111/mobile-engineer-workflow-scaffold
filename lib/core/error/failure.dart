/// Represents a typed failure that can be returned from a Repository.
/// Used with Either<Failure, T> from fpdart.
///
/// Usage:
///   final result = await repository.getProfile(userId);
///   result.fold(
///     (failure) => // handle error,
///     (profile)  => // use data,
///   );
sealed class Failure {
  const Failure(this.message);
  final String message;
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message);
}
