import 'package:dio/dio.dart';
import '../../../../core/error/failure.dart';
import '../models/user_profile_model.dart';

/// Remote DataSource: only responsibility is talking to the API.
/// No caching logic, no business rules — just raw data access.
abstract interface class UserProfileRemoteDataSource {
  Future<UserProfileModel> getProfile(String userId);
  Future<UserProfileModel> updateProfile({
    required String userId,
    required String displayName,
    required String bio,
  });
}

class UserProfileRemoteDataSourceImpl implements UserProfileRemoteDataSource {
  const UserProfileRemoteDataSourceImpl(this._dio);
  final Dio _dio;

  @override
  Future<UserProfileModel> getProfile(String userId) async {
    try {
      final response = await _dio.get('/users/\$userId');
      return UserProfileModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw NetworkFailure(e.message ?? 'Network error fetching profile');
    }
  }

  @override
  Future<UserProfileModel> updateProfile({
    required String userId,
    required String displayName,
    required String bio,
  }) async {
    try {
      final response = await _dio.patch(
        '/users/\$userId',
        data: {'display_name': displayName, 'bio': bio},
      );
      return UserProfileModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw NetworkFailure(e.message ?? 'Network error updating profile');
    }
  }
}
