import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sweatnotes/shared/widgets/date_field.dart';

import '../../shared/widgets/regular_text_field.dart';
import '../../widgets/button.dart';
import '../../widgets/layout.dart';
import '../training_block/services/training_blocks_service.dart';

class TrainingBlockCreateScreen extends ConsumerStatefulWidget {
  const TrainingBlockCreateScreen({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _TrainingBlockCreateScreen();
}

class _TrainingBlockCreateScreen extends ConsumerState<TrainingBlockCreateScreen> with RouteAware {
  final _trainingBlockNameController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final trainingBlocksService = ref.watch(trainingBlocksServiceProvider);

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
            Button(
              label: 'Create',
              isLoading: _isLoading,
              onPressed: () async {
                final pop = context.pop;

                setState(() => _isLoading = true);

                await trainingBlocksService.create(
                  name: _trainingBlockNameController.text,
                  startedAt: Timestamp.fromDate(_selectedDate),
                );

                setState(() => _isLoading = false);

                pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
