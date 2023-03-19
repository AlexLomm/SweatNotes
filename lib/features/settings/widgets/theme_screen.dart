import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../widgets/go_back_button.dart';
import '../../../widgets/layout.dart';
import 'color_switcher_widget.dart';
import 'theme_switcher_widget.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      leading: GoBackButton(onPressed: () => context.pop()),
      appBarTitle: Text(
        'Theme',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          ThemeSwitcherWidget(),
          SizedBox(height: 52.0),
          ColorSwitcherWidget(),
        ],
      ),
    );
  }
}
