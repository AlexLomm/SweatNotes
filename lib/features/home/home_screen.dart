import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sweatnotes/features/home/settings_button_with_tooltip.dart';
import 'package:sweatnotes/features/training_block/widget_params.dart';
import 'package:sweatnotes/shared/widgets/tutor/core/tutor.dart';

import '../../router/router.dart';
import '../../shared/services/shared_preferences.dart';
import '../../shared/widgets/tutor/core/tutor_controller.dart';
import '../../widgets/layout.dart';
import '../auth/services/auth_service.dart';
import '../settings/show_archived_training_blocks_switcher.dart';
import '../settings/tutorial_settings.dart';
import '../training_block/data/models_client/training_block_client.dart';
import '../training_block/services/training_blocks_stream.dart';
import 'archived_training_blocks_button_with_tooltip.dart';
import 'create_training_block_button_with_tooltip.dart';
import 'training_blocks.dart';

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

  final _areTutorialsEnabled = ValueNotifier<bool>(false);
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _areTutorialsEnabled.addListener(_playTutorial);
    _controller.isReady.addListener(_playTutorial);
  }

  _playTutorial() {
    if (!_controller.isReady.value || !_areTutorialsEnabled.value) {
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _timer = Timer(
        WidgetParams.tutorialTooltipAnimationDelayDuration,
        _controller.next,
      );
    });
  }

  @override
  void dispose() {
    // calling ref.read causes the "Looking up a
    // deactivated widget's ancestor is unsafe" error
    _routeObserver.unsubscribe(this);

    _areTutorialsEnabled.dispose();
    _controller.dispose();
    _timer?.cancel();

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _routeObserver = ref.read(routeObserverProvider);

    _routeObserver.subscribe(this, ModalRoute.of(context)!);
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
    _areTutorialsEnabled.value = GoRouter.of(context).location == '/';
  }

  @override
  Widget build(BuildContext context) {
    final tutorialSettings = ref.watch(tutorialSettingsProvider);

    final authService = ref.watch(authServiceProvider);
    final showArchivedTrainingBlocks = ref.watch(
      showArchivedTrainingBlocksSwitcherProvider,
    );

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

    return Tutor(
      controller: _controller,
      child: Layout(
        leading: const CreateTrainingBlockButtonWithTooltip(),
        actions: [
          ArchivedTrainingBlocksButtonWithTooltip(
            hasAtLeastOneTrainingBlock: hasAtLeastOneTrainingBlock,
          ),
          const SettingsButtonWithTooltip()
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
