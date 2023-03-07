import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rive/rive.dart';

import '../../theme_switcher.dart';
import '../../widgets/button.dart';
import '../../widgets/custom_bottom_sheet/custom_bottom_sheet.dart';
import '../../widgets/empty_page_placeholder.dart';
import '../../widgets/layout.dart';
import '../../widgets/text_editor_single_line.dart';
import '../auth/services/auth_service.dart';
import '../training_block/data/models/training_block.dart';
import '../training_block/services/training_blocks_service.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final Stream<List<TrainingBlock>> trainingBlocksStream;

  @override
  void initState() {
    super.initState();

    final trainingBlocksService = ref.read(trainingBlocksServiceProvider);
    trainingBlocksStream = trainingBlocksService.trainingBlocks;
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    final authService = ref.watch(authServiceProvider);
    final themeSwitcher = ref.watch(themeSwitcherProvider.notifier);
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
          onPressed: () => themeSwitcher.toggle(),
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
        // builder is needed in order for the
        // Scaffold.of(context).openDrawer() to work
        Builder(builder: (context) {
          return IconButton(
            icon: Icon(
              Icons.settings_outlined,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            tooltip: 'Open settings',
            splashRadius: 20,
            onPressed: () => Scaffold.of(context).openEndDrawer(),
          );
        }),
      ],
      child: StreamBuilder<List<TrainingBlock>>(
        stream: trainingBlocksStream,
        builder: (context, snapshot) {
          final appBarHeight = Scaffold.of(context).appBarMaxHeight ?? 0;
          final safeAreaHeight = mq.size.height -
              mq.padding.top -
              mq.padding.bottom -
              appBarHeight;

          final data = snapshot.data;

          if (data == null) {
            return const Center(child: CircularProgressIndicator());
          }

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
                    key: Key(trainingBlock.id),
                    trainingBlock: trainingBlock,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _TrainingBlockButton extends StatelessWidget {
  final TrainingBlock trainingBlock;

  const _TrainingBlockButton({Key? key, required this.trainingBlock})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Button(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        borderRadius: 12,
        label: trainingBlock.name,
        onPressed: () => context.go('/${trainingBlock.id}'),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              trainingBlock.name,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            ),
            const _ArrowRightIcon(),
          ],
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