import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../training_block/data/models/training_block.dart';
import '../training_block/services/training_blocks_state.dart';
import '../../widgets/layout.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TrainingBlocksState trainingBlocksState;

  @override
  void initState() {
    super.initState();
    trainingBlocksState = TrainingBlocksState();
  }

  @override
  void dispose() {
    trainingBlocksState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Layout(
      child: StreamBuilder<List<TrainingBlock>>(
        stream: trainingBlocksState.trainingBlocks,
        builder: (context, snapshot) {
          final data = snapshot.data;

          if (data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SizedBox(
            height: mq.size.height,
            width: mq.size.width,
            child: ListView(
              children: [
                for (final trainingBlock
                    in snapshot.data as List<TrainingBlock>)
                  TextButton(
                    child: Text(trainingBlock.name),
                    onPressed: () => context.go('/${trainingBlock.id}'),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
