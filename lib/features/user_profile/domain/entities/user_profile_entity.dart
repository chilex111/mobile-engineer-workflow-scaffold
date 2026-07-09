/// Pure domain entity — no Flutter imports, no JSON logic.
/// This is the shape of user profile data the rest of the app works with.
class UserProfileEntity {
  const UserProfileEntity({
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
}
