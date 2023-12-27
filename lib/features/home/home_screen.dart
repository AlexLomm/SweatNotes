import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sweatnotes/shared/widgets/tutor/core/tutor.dart';

import '../../router/router.dart';
import '../../shared/services/shared_preferences.dart';
import '../../shared/widgets/tutor/core/tutor_controller.dart';
import '../../shared/widgets/tutor/core/tutor_tooltip.dart';
import '../../widgets/layout.dart';
import '../auth/services/auth_service.dart';
import '../settings/show_archived_training_blocks_switcher.dart';
import '../settings/tutorial_settings.dart';
import '../training_block/data/models_client/training_block_client.dart';
import '../training_block/services/training_blocks_stream.dart';
import 'training_blocks.dart';
import 'tutorial_tooltip_create_training_block.dart';
import 'tutorial_tooltip_see_archived_training_blocks.dart';
import 'tutorial_tooltip_see_settings.dart';

const int orderCreateTrainingBlock = 0;
const int orderSettings = 1;

const int orderTrainingBlockList = 10;
const int orderShowArchived = 11;

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with RouteAware {
  late RouteObserver _routeObserver;
  List<TrainingBlockClient>? _cachedTrainingBlocks;

  bool hasAtLeastOneTrainingBlock = false;

  final _controller = TutorController();

  final isEnabled = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();

    isEnabled.addListener(_playTutorial);
    _controller.isReady.addListener(_playTutorial);
  }

  _playTutorial() {
    if (!_controller.isReady.value || !isEnabled.value) {
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.next();
    });
  }

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

    isEnabled.dispose();
    _controller.dispose();

    super.dispose();
  }

  @override
  void didPush() {
    final prefs = ref.read(prefsProvider);

    prefs.setString('initialLocation', '/');

    _checkRoute();
  }

  @override
  void didPushNext() {
    _checkRoute();
  }

  @override
  void didPop() {
    _checkRoute();
  }

  @override
  void didPopNext() {
    _checkRoute();
  }

  // this check is needed to prevent the tutorial playing when the
  // screen it's on is hidden (i.e home screen when on one of the
  // descendant screens like settings, training block, etc.)
  _checkRoute() {
    isEnabled.value = GoRouter.of(context).location == '/';
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final tutorialSettings = ref.watch(tutorialSettingsProvider);
    final tutorialSettingsNotifier =
        ref.watch(tutorialSettingsProvider.notifier);

    final authService = ref.watch(authServiceProvider);
    final showArchivedTrainingBlocksSwitcher =
        ref.watch(showArchivedTrainingBlocksSwitcherProvider.notifier);
    final showArchivedTrainingBlocks =
        ref.watch(showArchivedTrainingBlocksSwitcherProvider);

    final trainingBlocks = ref.watch(
      trainingBlocksStreamProvider(includeArchived: showArchivedTrainingBlocks),
    );

    // spinner is extracted, because when inlined inside the `loading`
    // callback a weird dot is displayed instead of the spinner
    //
    // in order to reproduce this, inline the spinner and do a hard
    // refresh of the app
    const spinner = Column(children: [
      Gap(64),
      Center(child: Text('Loading...')),
    ]);

    final showCreateTrainingBlockTooltip =
        !tutorialSettings.isCreateTrainingBlockSeen;
    final showArchiveTrainingBlocksTooltip =
        !tutorialSettings.isSeeArchivedTrainingBlocksSeen &&
            hasAtLeastOneTrainingBlock;
    final showSettingsTooltip = !tutorialSettings.isSettingsSeen;

    return Tutor(
      controller: _controller,
      child: Layout(
        leading: TutorTooltip(
          order: orderCreateTrainingBlock,
          active: showCreateTrainingBlockTooltip,
          onClose: () {
            tutorialSettingsNotifier.set((prevState) {
              return prevState.copyWith(isCreateTrainingBlockSeen: true);
            });
          },
          buildTooltip: (_, __) => const TutorialTooltipCreateTrainingBlock(),
          buildChild: (controller) => IconButton(
            icon: Icon(Icons.add, color: cs.onSurface),
            tooltip: 'Add new training block',
            splashRadius: 20,
            onPressed: () {
              if (controller.isInProgress) {
                controller.next();
              } else {
                context.pushNamed(RouteNames.trainingBlockCreateUpdate);
              }
            },
          ),
        ),
        actions: [
          TutorTooltip(
            order: orderShowArchived,
            active: showArchiveTrainingBlocksTooltip,
            onClose: () {
              tutorialSettingsNotifier.set((prevState) {
                return prevState.copyWith(
                  isSeeArchivedTrainingBlocksSeen: true,
                );
              });
            },
            buildTooltip: (_, __) =>
                const TutorialTooltipSeeArchivedTrainingBlocks(),
            buildChild: (controller) => IconButton(
              icon: Icon(
                showArchivedTrainingBlocks
                    ? Icons.cancel_outlined
                    : Icons.unarchive_outlined,
                color: showArchivedTrainingBlocks ? cs.tertiary : cs.onSurface,
              ),
              tooltip: 'Archive',
              splashRadius: 20,
              onPressed: () {
                if (controller.isInProgress) {
                  controller.next();
                } else {
                  showArchivedTrainingBlocksSwitcher.toggle();
                }
              },
            ),
          ),
          TutorTooltip(
            order: orderSettings,
            active: showSettingsTooltip,
            onClose: () {
              tutorialSettingsNotifier.set((prevState) {
                return prevState.copyWith(isSettingsSeen: true);
              });
            },
            buildTooltip: (_, __) => const TutorialTooltipSeeSettings(),
            buildChild: (controller) => IconButton(
              icon: Icon(Icons.settings_outlined, color: cs.onSurface),
              tooltip: 'Settings',
              splashRadius: 20,
              onPressed: () {
                if (controller.isInProgress) {
                  controller.next();
                } else {
                  context.pushNamed(RouteNames.settings);
                }
              },
            ),
          ),
        ],
        child: trainingBlocks.when(
          loading: () {
            final data = _cachedTrainingBlocks;

            if (data == null) return spinner;

            return TrainingBlocks(data: data);
          },
          data: (data) {
            _cachedTrainingBlocks = data;

            setState(() => hasAtLeastOneTrainingBlock = data.isNotEmpty);

            return TrainingBlocks(data: data);
          },
          error: (error, stackTrace) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) => authService.signOut(),
            );

            return Center(child: Text(error.toString()));
          },
        ),
      ),
    );
  }
}
