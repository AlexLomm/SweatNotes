import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sweatnotes/features/training_block/data/models_client/exercise_day_client.dart';

import '../../shared/widgets/regular_text_field.dart';
import '../../widgets/button.dart';
import '../../widgets/layout.dart';
import 'data/models_client/training_block_client.dart';
import 'services/exercise_days_service.dart';

class ExerciseDayCreateUpdateScreen extends ConsumerStatefulWidget {
  final TrainingBlockClient trainingBlock;
  final ExerciseDayClient? exerciseDay;

  const ExerciseDayCreateUpdateScreen({
    Key? key,
    required this.trainingBlock,
    this.exerciseDay,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ExerciseDayCreateUpdateScreen();
}

class _ExerciseDayCreateUpdateScreen extends ConsumerState<ExerciseDayCreateUpdateScreen> with RouteAware {
  final _exerciseDayNameController = TextEditingController();
  late int? _selectedWeekDay;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _exerciseDayNameController.text = widget.exerciseDay?.name ?? '';
    _selectedWeekDay = widget.exerciseDay?.dbModel.weekDay;
  }

  @override
  Widget build(BuildContext context) {
    final exerciseDaysService = ref.watch(exerciseDaysServiceProvider);

    return Layout(
      onGoBackButtonTap: () => context.pop(),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RegularTextField(
              controller: _exerciseDayNameController,
              labelText: 'Exercise day name',
              hintText: 'Enter name',
            ),
            const SizedBox(height: 24.0),
            DropdownButton<int>(
              isExpanded: true,
              hint: const Text('Select week day'),
              value: _selectedWeekDay,
              alignment: Alignment.centerLeft,
              items: List.generate(
                7,
                (i) {
                  const weekDays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

                  return DropdownMenuItem<int>(
                    value: i,
                    child: Text(
                      weekDays[i],
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
                    ),
                  );
                },
              ),
              onChanged: (value) => setState(() => _selectedWeekDay = value),
            ),
            const SizedBox(height: 24.0),
            widget.exerciseDay == null
                ? Button(
                    label: 'Create',
                    isLoading: _isLoading,
                    onPressed: () async {
                      final pop = context.pop;

                      setState(() => _isLoading = true);

                      await exerciseDaysService.create(
                        name: _exerciseDayNameController.text,
                        trainingBlock: widget.trainingBlock,
                        weekDay: _selectedWeekDay,
                      );

                      setState(() => _isLoading = false);

                      pop();
                    },
                  )
                : Button(
                    label: 'Update',
                    isLoading: _isLoading,
                    onPressed: () async {
                      final pop = context.pop;

                      setState(() => _isLoading = true);

                      await exerciseDaysService.updateNameAndWeekDay(
                        trainingBlock: widget.trainingBlock,
                        exerciseDay: widget.exerciseDay!,
                        name: _exerciseDayNameController.text,
                        weekDay: _selectedWeekDay,
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
