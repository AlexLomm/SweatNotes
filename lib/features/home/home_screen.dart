import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rive/rive.dart';

import '../../widgets/button.dart';
import '../../widgets/layout.dart';
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

    return Layout(
      actions: [
        IconButton(
          icon: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          tooltip: 'Add new training block',
          splashRadius: 20,
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            Icons.settings_outlined,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          tooltip: 'Open settings',
          splashRadius: 20,
          onPressed: () {},
        ),
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

          return SizedBox(
            height: safeAreaHeight,
            width: mq.size.width,
            child: data.isEmpty
                // TODO: add dark mode
                ? const RiveAnimation.asset(
                    alignment: Alignment.center,
                    'assets/rive/empty-state-home-light.riv',
                  )
                // TODO: convert to ListView.builder
                : ListView(
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
