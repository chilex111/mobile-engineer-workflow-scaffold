/// Single source of truth for every route name in the app.
/// 
/// Always navigate via AppRoute.x.name — never use raw strings.
/// Adding a screen = adding one line here.
/// A typo here is a compile-time error, not a silent runtime failure.
enum AppRoute {
  splash,
  userProfile,
  editProfile,
}
