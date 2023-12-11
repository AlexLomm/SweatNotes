import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tuple/tuple.dart';

import '../../app.dart';
import '../../router/router.dart';
import '../../shared/services/shared_preferences.dart';
import '../../widgets/dismissible_button.dart';
import '../../widgets/empty_page_placeholder.dart';
import '../../widgets/layout.dart';
import '../auth/services/auth_service.dart';
import '../training_block/services/training_blocks_service.dart';
import '../training_block/services/training_blocks_stream.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

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
    final trainingBlocksService = ref.watch(trainingBlocksServiceProvider);

    return Layout(
      leading: IconButton(
        icon: Icon(Icons.add, color: Theme.of(context).colorScheme.onSurface),
        tooltip: 'Add new training block',
        splashRadius: 20,
        onPressed: () => context.pushNamed(RouteNames.trainingBlockCreateUpdate),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 16),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              trainingBlock.startedAtFormatted,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context).colorScheme.onBackground,
                                  ),
                            ),
                          ),
                        ),
                        DismissibleButton(
                          key: Key(trainingBlock.dbModel.id),
                          id: trainingBlock.dbModel.id,
                          label: trainingBlock.dbModel.name,
                          right: Icon(
                            Icons.arrow_forward,
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                          ),
                          onPressed: () => context.push('/${trainingBlock.dbModel.id}'),
                          isArchivable: true,
                          confirmDismiss: (direction) async {
                            if (direction == DismissDirection.endToStart) return true;

                            context.pushNamed(
                              RouteNames.trainingBlockCreateUpdate,
                              extra: Tuple2(trainingBlock, true),
                            );

                            return false;
                          },
                          onDismissed: (direction) {
                            if (direction != DismissDirection.endToStart) return;

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
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
