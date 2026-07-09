import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'app_route.dart';
import '../../features/user_profile/presentation/screens/user_profile_screen.dart';
import '../../features/user_profile/presentation/screens/edit_profile_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

/// All routes are defined here — never scattered across feature files.
/// 
/// Route guards (redirect logic) read from Riverpod providers here,
/// not inside individual screens. This keeps access-control in one place.
final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/profile',

    // Route guard example — uncomment and wire to your auth provider:
    // redirect: (context, state) {
    //   final isLoggedIn = ref.read(authStateProvider).isLoggedIn;
    //   if (!isLoggedIn) return '/login';
    //   return null;
    // },

    routes: [
      GoRoute(
        path: '/profile',
        name: AppRoute.userProfile.name,
        builder: (context, state) => const UserProfileScreen(),
        routes: [
          // Nested: lives inside profile, so back returns to profile.
          GoRoute(
            path: 'edit',
            name: AppRoute.editProfile.name,
            builder: (context, state) => const EditProfileScreen(),
          ),
        ],
      ),
    ],

    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Page not found: \${state.error}')),
    ),
  );
});
