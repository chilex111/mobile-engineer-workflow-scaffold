import '../../domain/entities/user_profile_entity.dart';

/// Data model: handles JSON serialisation/deserialisation.
/// Converts between raw API/cache data and the domain entity.
/// The domain layer never sees this class.
class UserProfileModel {
  const UserProfileModel({
    required this.id,
    required this.displayName,
    required this.email,
    required this.avatarUrl,
    required this.bio,
  });

  final String id;
  final String displayName;
  final String email;
  final String avatarUrl;
  final String bio;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id:          json['id']           as String,
      displayName: json['display_name'] as String,
      email:       json['email']        as String,
      avatarUrl:   json['avatar_url']   as String? ?? '',
      bio:         json['bio']          as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id':           id,
    'display_name': displayName,
    'email':        email,
    'avatar_url':   avatarUrl,
    'bio':          bio,
  };

  /// Convert to the domain entity the rest of the app uses.
  UserProfileEntity toEntity() => UserProfileEntity(
    id:          id,
    displayName: displayName,
    email:       email,
    avatarUrl:   avatarUrl,
    bio:         bio,
  );

  factory UserProfileModel.fromEntity(UserProfileEntity entity) {
    return UserProfileModel(
      id:          entity.id,
      displayName: entity.displayName,
      email:       entity.email,
      avatarUrl:   entity.avatarUrl,
      bio:         entity.bio,
    );
  }
}
