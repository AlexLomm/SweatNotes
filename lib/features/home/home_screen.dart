import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sweatnotes/features/home/training_block_button.dart';

import '../../router/router.dart';
import '../../shared/services/shared_preferences.dart';
import '../../widgets/empty_page_placeholder.dart';
import '../../widgets/layout.dart';
import '../auth/services/auth_service.dart';
import '../settings/show_archived_training_blocks_switcher.dart';
import '../training_block/data/models_client/training_block_client.dart';
import '../training_block/services/training_blocks_stream.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with RouteAware {
  late RouteObserver _routeObserver;
  List<TrainingBlockClient>? _cachedTrainingBlocks;

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
    final cs = Theme.of(context).colorScheme;

    final authService = ref.watch(authServiceProvider);
    final showArchivedTrainingBlocksSwitcher = ref.watch(
      showArchivedTrainingBlocksSwitcherProvider.notifier,
    );
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

    return Layout(
      leading: IconButton(
        icon: Icon(Icons.add, color: cs.onSurface),
        tooltip: 'Add new training block',
        splashRadius: 20,
        onPressed: () => context.pushNamed(
          RouteNames.trainingBlockCreateUpdate,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            showArchivedTrainingBlocks
                ? Icons.cancel_outlined
                : Icons.unarchive_outlined,
            color: showArchivedTrainingBlocks ? cs.tertiary : cs.onSurface,
          ),
          tooltip: 'Archive',
          splashRadius: 20,
          onPressed: showArchivedTrainingBlocksSwitcher.toggle,
        ),
        IconButton(
          icon: Icon(
            Icons.settings_outlined,
            color: cs.onSurface,
          ),
          tooltip: 'Settings',
          splashRadius: 20,
          onPressed: () => context.push('/settings'),
        ),
      ],
      child: trainingBlocks.when(
        loading: () {
          final data = _cachedTrainingBlocks;

          return data == null ? spinner : _TrainingBlocks(data: data);
        },
        data: (data) {
          _cachedTrainingBlocks = data;

          return _TrainingBlocks(data: data);
        },
        error: (error, stackTrace) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => authService.signOut(),
          );

          return Center(child: Text(error.toString()));
        },
      ),
    );
  }
}

class _TrainingBlocks extends StatelessWidget {
  final List<TrainingBlockClient> data;

  const _TrainingBlocks({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final mq = MediaQuery.of(context);

        final appBarHeight = Scaffold.of(context).appBarMaxHeight ?? 0;
        final safeAreaHeight =
            mq.size.height - mq.padding.top - mq.padding.bottom - appBarHeight;

        if (data.isEmpty) {
          return const Center(child: EmptyPagePlaceholder());
        }

        return SizedBox(
          height: safeAreaHeight,
          width: mq.size.width,
          child: ListView(children: [
            for (final trainingBlock in data)
              TrainingBlockButton(
                key: Key(trainingBlock.dbModel.id),
                trainingBlock: trainingBlock,
              ),
          ]),
        );
      },
    );
  }
}
