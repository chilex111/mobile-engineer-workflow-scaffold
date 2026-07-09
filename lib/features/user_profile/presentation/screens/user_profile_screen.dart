import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/router/app_route.dart';
import '../providers/user_profile_provider.dart';
import '../widgets/profile_avatar_widget.dart';
import '../widgets/profile_info_row_widget.dart';

/// The UI layer only:
///   - reads state from the provider
///   - calls provider methods on user actions
///   - contains no business logic
class UserProfileScreen extends ConsumerWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(userProfileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            // Navigate using named route — never Navigator.push directly
            onPressed: () => context.pushNamed(AppRoute.editProfile.name),
          ),
        ],
      ),
      body: profileAsync.when(
        // State 1: Loading
        loading: () => const Center(child: CircularProgressIndicator()),
        // State 2: Error
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: AppColors.error, size: 48),
              const SizedBox(height: AppSpacing.medium),
              Text('Could not load profile', style: AppTextStyles.body),
              const SizedBox(height: AppSpacing.small),
              TextButton(
                onPressed: () => ref.invalidate(userProfileProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        // State 3: Data
        data: (profile) => SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileAvatarWidget(avatarUrl: profile.avatarUrl, name: profile.displayName),
              const SizedBox(height: AppSpacing.sectionGapMedium),
              Text('Profile details', style: AppTextStyles.heading2),
              const SizedBox(height: AppSpacing.sectionGapSmall),
              ProfileInfoRowWidget(label: 'Name',  value: profile.displayName),
              ProfileInfoRowWidget(label: 'Email', value: profile.email),
              ProfileInfoRowWidget(label: 'Bio',   value: profile.bio.isEmpty ? 'No bio yet' : profile.bio),
            ],
          ),
        ),
      ),
    );
  }
}
