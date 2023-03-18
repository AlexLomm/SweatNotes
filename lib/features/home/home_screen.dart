import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../router/router.dart';
import '../../shared_preferences.dart';
import '../../widgets/button.dart';
import '../../widgets/custom_bottom_sheet/custom_bottom_sheet.dart';
import '../../widgets/empty_page_placeholder.dart';
import '../../widgets/layout.dart';
import '../../widgets/text_editor_single_line.dart';
import '../auth/services/auth_service.dart';
import '../settings/theme_switcher.dart';
import '../training_block/data/models_client/training_block_client.dart';
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
      leading: IconButton(
        icon: Transform.rotate(
          angle: pi,
          child: Icon(
            Icons.logout,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        tooltip: 'Logout',
        splashRadius: 20,
        onPressed: () => authService.signOut(),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.wb_sunny_outlined,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          tooltip: 'Switch theme',
          splashRadius: 20,
          onPressed: () => themeSwitcher.setThemeMode(
            currentTheme == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark,
          ),
        ),
        IconButton(
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
      ],
      child: trainingBlocks.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        data: (data) => Builder(
          builder: (context) {
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
                    _TrainingBlockButton(
                      key: Key(trainingBlock.dbModel.id),
                      onDismissed: (_) => trainingBlocksService.archive(trainingBlock),
                      trainingBlock: trainingBlock,
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

class _TrainingBlockButton extends StatefulWidget {
  final DismissDirectionCallback? onDismissed;
  final TrainingBlockClient trainingBlock;

  const _TrainingBlockButton({
    Key? key,
    required this.onDismissed,
    required this.trainingBlock,
  }) : super(key: key);

  @override
  State<_TrainingBlockButton> createState() => _TrainingBlockButtonState();
}

class _TrainingBlockButtonState extends State<_TrainingBlockButton> {
  bool _isConfirmed = false;

  @override
  Widget build(BuildContext context) {
    const borderRadius = 12.0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      margin: const EdgeInsets.only(bottom: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Dismissible(
          key: Key(widget.trainingBlock.dbModel.id),
          direction: DismissDirection.endToStart,
          dismissThresholds: const {
            DismissDirection.endToStart: 0.25,
          },
          onUpdate: (direction) {
            if (direction.reached && !_isConfirmed) {
              HapticFeedback.lightImpact();
              setState(() => _isConfirmed = true);
            }

            if (!direction.reached && _isConfirmed) {
              HapticFeedback.lightImpact();
              setState(() => _isConfirmed = false);
            }
          },
          onDismissed: widget.onDismissed,
          background: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiaryContainer,
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: SizedBox(
                  width: 24.0,
                  child: Center(
                    child: Icon(
                      Icons.archive_outlined,
                      color: Theme.of(context).colorScheme.tertiary,
                      size: _isConfirmed ? 24.0 : 8.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          child: Button(
            borderRadius: 0,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 24.0,
            ),
            label: widget.trainingBlock.name,
            onPressed: () => context.go('/${widget.trainingBlock.dbModel.id}'),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.trainingBlock.name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
                const _ArrowRightIcon(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ArrowRightIcon extends StatelessWidget {
  const _ArrowRightIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: pi,
      child: Icon(
        Icons.arrow_back,
        color: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
    );
  }
}
