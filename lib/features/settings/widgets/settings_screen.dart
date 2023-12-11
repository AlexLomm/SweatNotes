import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/services/firebase.dart';
import '../../../shared/services/package_info.dart';
import '../../../shared/services/url_launcher.dart';
import '../../../widgets/button.dart';
import '../../../widgets/dismissible_button.dart';
import '../../../widgets/go_back_button.dart';
import '../../../widgets/layout.dart';
import '../../auth/services/auth_service.dart';
import '../../auth/services/user.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authService = ref.watch(authServiceProvider);
    final packageInfo = ref.watch(packageInfoProvider);
    final urlLauncher = ref.watch(urlLauncherProvider);

    final backgroundColor = ElevationOverlay.applySurfaceTint(
      Theme.of(context).colorScheme.surface,
      Theme.of(context).colorScheme.surface,
      1.0,
    );

    final textColor = Theme.of(context).colorScheme.onSurface;

    return Layout(
      centerTitle: false,
      isScrollable: false,
      leading: GoBackButton(onPressed: () => context.pop()),
      appBarTitle: Text(
        'Settings',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
      child: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              const _UserAvatarWithInfo(),
              const SizedBox(height: 24.0),
              DismissibleButton(
                backgroundColor: backgroundColor,
                textColor: textColor,
                id: '/settings/account',
                label: 'Account',
                right: Icon(Icons.keyboard_arrow_right, color: Theme.of(context).colorScheme.onSurface),
                onPressed: () => context.push('/settings/account'),
              ),
              // DismissibleButton(
              //   id: '/settings/unit',
              //   label: 'Unit',
              //   right: Icon(Icons.keyboard_arrow_right, color: Theme.of(context).colorScheme.onSurface),
              //   onPressed: () => context.push('/settings/unit'),
              // ),
              DismissibleButton(
                backgroundColor: backgroundColor,
                textColor: textColor,
                id: '/settings/theme',
                label: 'Theme',
                right: Icon(Icons.keyboard_arrow_right, color: Theme.of(context).colorScheme.onSurface),
                onPressed: () => context.push('/settings/theme'),
              ),
              DismissibleButton(
                backgroundColor: backgroundColor,
                textColor: textColor,
                id: 'https://sweatnotes.com/support',
                label: 'Support',
                right: Icon(Icons.open_in_new, color: Theme.of(context).colorScheme.onSurface),
                onPressed: () => urlLauncher.launch('https://sweatnotes.com/support'),
              ),
              DismissibleButton(
                backgroundColor: backgroundColor,
                textColor: textColor,
                id: 'https://sweatnotes.com/privacy-policy',
                label: 'Privacy Policy',
                right: Icon(Icons.open_in_new, color: Theme.of(context).colorScheme.onSurface),
                onPressed: () => urlLauncher.launch('https://sweatnotes.com/privacy-policy'),
              ),
              DismissibleButton(
                backgroundColor: backgroundColor,
                textColor: textColor,
                id: 'https://sweatnotes.com/terms-of-service',
                label: 'Terms of Service',
                right: Icon(Icons.open_in_new, color: Theme.of(context).colorScheme.onSurface),
                onPressed: () => urlLauncher.launch('https://sweatnotes.com/terms-of-service'),
              ),
              // DismissibleButton(
              //   id: '/settings/contact-us-on-discord',
              //   label: 'Contact us on Discord',
              //   right: Icon(Icons.open_in_new, color: Theme.of(context).colorScheme.onSurface),
              //   onPressed: () => context.push('/settings/contact-us-on-discord'),
              // ),
              // const Spacer(),
            ]),
          ),
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        packageInfo.when(
                          data: (value) {
                            // the `value.version == value.buildNumber` is needed because when the
                            // build number is not specified, the version is used as the build number
                            // @see https://github.com/fluttercommunity/plus_plugins/issues/1644
                            final versionString = kReleaseMode || value.version == value.buildNumber
                                ? value.version
                                : '${value.version}+${value.buildNumber}';

                            return 'Version $versionString';
                          },
                          error: (error, stackTrace) => '',
                          loading: () => '',
                        ),
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () => showDialog(
                              context: context,
                              builder: (context) => _DeleteAccountAlertDialog(
                                onCancel: context.pop,
                                onConfirm: authService.deleteAccount,
                              ),
                            ),
                            child: Text(
                              'Delete account',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(color: Theme.of(context).colorScheme.error),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          SizedBox(
                            width: 96.0,
                            child: Button(
                              onPressed: authService.signOut,
                              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                              child: Text(
                                'Log out',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(color: Theme.of(context).colorScheme.onSecondaryContainer),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _DeleteAccountAlertDialog extends StatelessWidget {
  final void Function() onCancel;
  final void Function() onConfirm;

  const _DeleteAccountAlertDialog({
    required this.onCancel,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: Text(
        'Danger!',
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
      content: Text(
        'Are you sure you want to delete your account? This action cannot be undone.',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
      actions: [
        TextButton(
          onPressed: onCancel,
          child: Text(
            'Cancel',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Theme.of(context).colorScheme.primary),
          ),
        ),
        TextButton(
          onPressed: onConfirm,
          child: Text(
            'Confirm',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Theme.of(context).colorScheme.error),
          ),
        ),
      ],
    );
  }
}

class _UserAvatarWithInfo extends ConsumerWidget {
  const _UserAvatarWithInfo();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firebaseAuth = ref.watch(firebaseAuthProvider);
    final user = ref.watch(userProvider);

    return user.when(
      data: (data) => ListTile(
        leading: const _Avatar(),
        title: Text(
          firebaseAuth.currentUser?.displayName ?? '',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
        subtitle: Text(
          firebaseAuth.currentUser?.email ?? '',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
      ),
      error: (error, _) => Text(error.toString()),
      loading: () => const CircularProgressIndicator(),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48.0,
      height: 48.0,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.person, color: Theme.of(context).colorScheme.onSurface),
    );
  }
}
