import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../shared/widgets/date_field.dart';
import '../../shared/widgets/regular_text_field.dart';
import '../../widgets/button.dart';
import '../../widgets/layout.dart';
import '../training_block/data/models_client/training_block_client.dart';
import '../training_block/services/training_block_details_stream.dart';
import '../training_block/services/training_blocks_service.dart';

class TrainingBlockCreateUpdateScreen extends ConsumerStatefulWidget {
  final TrainingBlockClient? trainingBlock;
  final bool isCopy;

  const TrainingBlockCreateUpdateScreen({
    super.key,
    this.trainingBlock,
    this.isCopy = false,
  });

  @override
  ConsumerState createState() => _TrainingBlockCreateScreen();
}

class _TrainingBlockCreateScreen
    extends ConsumerState<TrainingBlockCreateUpdateScreen> with RouteAware {
  bool _isButtonDisabled = true;

  final _trainingBlockNameController = TextEditingController();
  late DateTime _selectedDate;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    if (widget.isCopy) {
      _trainingBlockNameController.text = '${widget.trainingBlock?.name} copy';
      _selectedDate = DateTime.now();
    } else {
      _trainingBlockNameController.text = widget.trainingBlock?.name ?? '';
      _selectedDate =
          widget.trainingBlock?.startedAt?.toDate() ?? DateTime.now();
    }

    _updateIsButtonDisabled();
    _trainingBlockNameController.addListener(_updateIsButtonDisabled);
  }

  _updateIsButtonDisabled() {
    setState(
      () => _isButtonDisabled = _trainingBlockNameController.text.isEmpty,
    );
  }

  @override
  Widget build(BuildContext context) {
    final trainingBlocksService = ref.watch(trainingBlocksServiceProvider);

    final data = widget.trainingBlock == null
        ? const AsyncData(null)
        : ref.watch(trainingBlockDetailsStreamProvider(
            widget.trainingBlock!.dbModel.id,
            includeArchived: true,
          ));

    return Layout(
      onGoBackButtonTap: () => context.pop(),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RegularTextField(
              controller: _trainingBlockNameController,
              labelText: 'Training block name',
              hintText: 'Enter name',
            ),
            const SizedBox(height: 24.0),
            DateField(
              labelText: 'Pick a date',
              hintText: 'Enter date',
              selectedDate: _selectedDate,
              onDateSelected: (value) => setState(() => _selectedDate = value),
            ),
            const SizedBox(height: 24.0),
            if (widget.trainingBlock == null)
              Button(
                label: 'Create',
                isLoading: _isLoading,
                onPressed: _isButtonDisabled ? null : _create,
              ),
            if (widget.trainingBlock != null && !widget.isCopy)
              Button(
                label: 'Update',
                isLoading: _isLoading,
                onPressed: _isButtonDisabled ? null : _update,
              ),
            if (widget.trainingBlock != null && widget.isCopy)
              data.when(
                error: (error, stackTrace) => Text(error.toString()),
                loading: () => const Button(label: 'Copy', isLoading: true),
                data: (trainingBlockWithPersonalRecords) => Button(
                  label: 'Copy',
                  isLoading: _isLoading,
                  onPressed: _isButtonDisabled
                      ? null
                      : () => _copy(trainingBlockWithPersonalRecords!),
                ),
              )
          ],
        ),
      ),
    );
  }

  _create() async {
    final trainingBlocksService = ref.read(trainingBlocksServiceProvider);

    final pop = context.pop;

    setState(() => _isLoading = true);

    await trainingBlocksService.create(
      name: _trainingBlockNameController.text,
      startedAt: Timestamp.fromDate(_selectedDate),
    );

    setState(() => _isLoading = false);

    pop();
  }

  _update() async {
    final trainingBlocksService = ref.read(trainingBlocksServiceProvider);

    final pop = context.pop;

    setState(() => _isLoading = true);

    await trainingBlocksService.updateNameAndStartedAtDate(
      widget.trainingBlock!,
      name: _trainingBlockNameController.text,
      startedAt: Timestamp.fromDate(_selectedDate),
    );

    setState(() => _isLoading = false);

    pop();
  }

  _copy(TrainingBlockClient trainingBlockClient) async {
    final trainingBlocksService = ref.read(trainingBlocksServiceProvider);

    final pop = context.pop;

    setState(() => _isLoading = true);

    await trainingBlocksService.copyWithPersonalRecords(
      trainingBlockClient,
      trainingBlockName: _trainingBlockNameController.text,
      startedAt: Timestamp.fromDate(_selectedDate),
    );

    setState(() => _isLoading = false);

    pop();
  }
}
