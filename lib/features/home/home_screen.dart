import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app.dart';
import '../../router/router.dart';
import '../../shared/services/shared_preferences.dart';
import '../../widgets/custom_bottom_sheet/custom_bottom_sheet.dart';
import '../../widgets/dismissible_button.dart';
import '../../widgets/empty_page_placeholder.dart';
import '../../widgets/layout.dart';
import '../../widgets/text_editor_single_line.dart';
import '../auth/services/auth_service.dart';
import '../settings/theme_switcher.dart';
import '../training_block/services/training_blocks_service.dart';
import '../training_block/services/training_blocks_stream.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with RouteAware {
  late RouteObserver _routeObserver;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _routeObserver = ref.read(routeObserverProvider);

    _routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    // calling ref.read causes the "Looking up a
    // deactivated widget's ancestor is unsafe" error
    _routeObserver.unsubscribe(this);

    super.dispose();
  }

  @override
  void didPush() {
    final prefs = ref.read(prefsProvider);

    prefs.setString('initialLocation', '/');
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    final trainingBlocks = ref.watch(trainingBlocksStreamProvider);
    final authService = ref.watch(authServiceProvider);
    final themeSwitcher = ref.watch(themeSwitcherProvider.notifier);
    final currentTheme = ref.watch(themeSwitcherProvider);
    final trainingBlocksService = ref.watch(trainingBlocksServiceProvider);

    return Layout(
      // leading: IconButton(
      //   icon: Transform.rotate(
      //     angle: pi,
      //     child: Icon(Icons.logout, color: Theme.of(context).colorScheme.onSurface),
      //   ),
      //   tooltip: 'Logout',
      //   splashRadius: 20,
      //   onPressed: () => authService.signOut(),
      // ),
      leading: IconButton(
        icon: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        tooltip: 'Add new training block',
        splashRadius: 20,
        onPressed: () => CustomBottomSheet(
          height: CustomBottomSheet.allSpacing + TextEditorSingleLine.height,
          title: 'Add training block',
          child: TextEditorSingleLine(
            value: '',
            onSubmitted: (String text) {
              trainingBlocksService.create(name: text);

              Navigator.of(context).pop();
            },
          ),
        ).show(context),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.settings_outlined,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          tooltip: 'Settings',
          splashRadius: 20,
          onPressed: () => context.push('/settings'),
        ),
        // IconButton(
        //   icon: Icon(
        //     Icons.wb_sunny_outlined,
        //     color: Theme.of(context).colorScheme.onSurface,
        //   ),
        //   tooltip: 'Switch theme',
        //   splashRadius: 20,
        //   onPressed: () => themeSwitcher.setThemeMode(
        //     currentTheme == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark,
        //   ),
        // ),
      ],
      child: trainingBlocks.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) {
          WidgetsBinding.instance.addPostFrameCallback((_) => authService.signOut());

          return Center(child: Text(error.toString()));
        },
        data: (data) => Builder(
          builder: (context) {
            final messenger = ref.watch(messengerProvider);
            final appBarHeight = Scaffold.of(context).appBarMaxHeight ?? 0;
            final safeAreaHeight = mq.size.height - mq.padding.top - mq.padding.bottom - appBarHeight;

            if (data.isEmpty) {
              return const Center(child: EmptyPagePlaceholder());
            }

            return SizedBox(
              height: safeAreaHeight,
              width: mq.size.width,
              child: ListView(
                children: [
                  for (final trainingBlock in data)
                    DismissibleButton(
                      key: Key(trainingBlock.dbModel.id),
                      id: trainingBlock.dbModel.id,
                      label: trainingBlock.dbModel.name,
                      right: Icon(
                        Icons.arrow_forward,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      onPressed: () => context.push('/${trainingBlock.dbModel.id}'),
                      onDismissed: (_) {
                        trainingBlocksService.archive(trainingBlock, true);

                        messenger?.showSnackBar(
                          SnackBar(
                            content: Text('Training block "${trainingBlock.dbModel.name}" archived'),
                            action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () => trainingBlocksService.archive(trainingBlock, false),
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
