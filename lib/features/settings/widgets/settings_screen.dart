import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../widgets/dismissible_button.dart';
import '../../../widgets/go_back_button.dart';
import '../../../widgets/layout.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      leading: GoBackButton(onPressed: () => context.go('/')),
      appBarTitle: Text(
        'Settings',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DismissibleButton(
            id: '/settings/account',
            label: 'Account',
            right: Icon(Icons.keyboard_arrow_right, color: Theme.of(context).colorScheme.onSurface),
            onPressed: () => context.go('/settings/account'),
          ),
          DismissibleButton(
            id: '/settings/unit',
            label: 'Unit',
            right: Icon(Icons.keyboard_arrow_right, color: Theme.of(context).colorScheme.onSurface),
            onPressed: () => context.go('/settings/unit'),
          ),
          DismissibleButton(
            id: '/settings/theme',
            label: 'Theme',
            right: Icon(Icons.keyboard_arrow_right, color: Theme.of(context).colorScheme.onSurface),
            onPressed: () => context.go('/settings/theme'),
          ),
          DismissibleButton(
            id: '/settings/contact-us-on-discord',
            label: 'Contact us on Discord',
            right: Icon(Icons.open_in_new, color: Theme.of(context).colorScheme.onSurface),
            onPressed: () => context.go('/settings/contact-us-on-discord'),
          ),
        ],
      ),
    );
  }
}
