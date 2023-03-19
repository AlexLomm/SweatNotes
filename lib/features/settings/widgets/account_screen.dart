import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../widgets/go_back_button.dart';
import '../../../widgets/layout.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      leading: GoBackButton(onPressed: () => context.pop()),
      appBarTitle: Text(
        'Account',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [],
      ),
    );
  }
}
