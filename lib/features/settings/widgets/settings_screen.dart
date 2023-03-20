import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../firebase.dart';
import '../../../widgets/dismissible_button.dart';
import '../../../widgets/go_back_button.dart';
import '../../../widgets/layout.dart';
import '../../auth/services/user_stream.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      centerTitle: false,
      leading: GoBackButton(onPressed: () => context.pop()),
      appBarTitle: Text(
        'Settings',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _UserAvatarWithInfo(),
          const SizedBox(height: 24.0),
          DismissibleButton(
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
            id: '/settings/theme',
            label: 'Theme',
            right: Icon(Icons.keyboard_arrow_right, color: Theme.of(context).colorScheme.onSurface),
            onPressed: () => context.push('/settings/theme'),
          ),
          // DismissibleButton(
          //   id: '/settings/contact-us-on-discord',
          //   label: 'Contact us on Discord',
          //   right: Icon(Icons.open_in_new, color: Theme.of(context).colorScheme.onSurface),
          //   onPressed: () => context.push('/settings/contact-us-on-discord'),
          // ),
        ],
      ),
    );
  }
}

class _UserAvatarWithInfo extends ConsumerWidget {
  const _UserAvatarWithInfo({Key? key}) : super(key: key);

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
  const _Avatar({Key? key}) : super(key: key);

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
