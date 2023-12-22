import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sweatnotes/features/training_block/data/models_client/training_block_client.dart';
import 'package:tuple/tuple.dart';

import '../../app.dart';
import '../../router/router.dart';
import '../../widgets/dismissible_button.dart';
import '../training_block/services/training_blocks_service.dart';

class TrainingBlockButton extends ConsumerStatefulWidget {
  final TrainingBlockClient trainingBlock;

  const TrainingBlockButton({super.key, required this.trainingBlock});

  @override
  ConsumerState createState() => _TrainingBlockButtonState();
}

class _TrainingBlockButtonState extends ConsumerState<TrainingBlockButton> {
  @override
  Widget build(BuildContext context) {
    final messenger = ref.watch(messengerProvider);
    final trainingBlocksService = ref.watch(trainingBlocksServiceProvider);

    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    final isUnarchived = widget.trainingBlock.archivedAt == null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 16),
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: Text(
              widget.trainingBlock.startedAtFormatted,
              style: tt.bodyMedium?.copyWith(color: cs.onBackground),
            ),
          ),
        ),
        DismissibleButton(
          key: Key(
            "${widget.trainingBlock.dbModel.id}${widget.trainingBlock.dbModel.archivedAt == null ? '' : '-archived'}",
          ),
          id: widget.trainingBlock.dbModel.id,
          label: widget.trainingBlock.dbModel.name,
          backgroundColor: isUnarchived
              ? cs.surfaceVariant
              : cs.onTertiary.withOpacity(0.67),
          right: Icon(
            isUnarchived ? Icons.arrow_forward : Icons.unarchive_outlined,
            color: cs.onPrimaryContainer,
          ),
          onPressed: () {
            final isUnarchived = widget.trainingBlock.archivedAt == null;

            if (isUnarchived) {
              context.push('/${widget.trainingBlock.dbModel.id}');

              return;
            }

            trainingBlocksService.archive(widget.trainingBlock, false);

            messenger?.showSnackBar(
              SnackBar(
                content: Text(
                  'Training block "${widget.trainingBlock.dbModel.name}" unarchived',
                ),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () => trainingBlocksService.archive(
                    widget.trainingBlock,
                    true,
                  ),
                ),
              ),
            );
          },
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.endToStart) return true;

            context.pushNamed(
              RouteNames.trainingBlockCreateUpdate,
              extra: Tuple2(widget.trainingBlock, true),
            );

            return false;
          },
          isArchivable: isUnarchived,
          onDismissed: isUnarchived
              ? (direction) {
                  if (direction != DismissDirection.endToStart) return;

                  trainingBlocksService.archive(widget.trainingBlock, true);

                  messenger?.showSnackBar(
                    SnackBar(
                      content: Text(
                        'Training block "${widget.trainingBlock.dbModel.name}" archived',
                      ),
                      action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () => trainingBlocksService.archive(
                          widget.trainingBlock,
                          false,
                        ),
                      ),
                    ),
                  );
                }
              : null,
        )
      ],
    );
  }
}
