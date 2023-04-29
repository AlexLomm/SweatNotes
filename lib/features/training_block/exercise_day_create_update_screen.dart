import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sweatnotes/features/training_block/data/models_client/exercise_day_client.dart';

import '../../router/router.dart';
import '../../shared/widgets/regular_text_field.dart';
import '../../widgets/button.dart';
import '../../widgets/layout.dart';
import 'services/exercise_days_service.dart';
import 'services/training_block_details_stream.dart';

class ExerciseDayCreateUpdateScreen extends ConsumerStatefulWidget {
  final String trainingBlockId;
  final ExerciseDayClient? exerciseDay;

  const ExerciseDayCreateUpdateScreen({
    Key? key,
    required this.trainingBlockId,
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
    final data = ref.watch(trainingBlockDetailsStreamProvider(widget.trainingBlockId));

    return Layout(
      onGoBackButtonTap: () => context.pop(),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: data.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (Object error, StackTrace stackTrace) => Center(child: Text(error.toString())),
          data: (trainingBlock) {
            final isStartDateSettable = trainingBlock?.startedAt == null;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RegularTextField(
                  controller: _exerciseDayNameController,
                  labelText: 'Exercise day name',
                  hintText: 'Enter name',
                ),
                const SizedBox(height: 24.0),
                if (isStartDateSettable)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: MaterialBanner(
                      dividerColor: Colors.transparent,
                      padding: const EdgeInsets.all(12.0),
                      content: const Text(
                        'In order to be able to specify the "week day", the "start date" should be set for the parent training block first.',
                      ),
                      contentTextStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Theme.of(context).colorScheme.onTertiaryContainer),
                      backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                      forceActionsBelow: true,
                      actions: [
                        TextButton(
                          onPressed: () => context.pushNamed(
                            RouteNames.trainingBlockCreateUpdate,
                            extra: trainingBlock,
                          ),
                          child: const Text('SET START DATE'),
                        ),
                      ],
                    ),
                  ),
                Opacity(
                  opacity: isStartDateSettable ? 0.67 : 1.0,
                  child: DropdownButton<int>(
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
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(isStartDateSettable ? 0.67 : 1.0)),
                          ),
                        );
                      },
                    ),
                    onChanged: isStartDateSettable
                        //
                        ? null
                        : (value) => setState(() => _selectedWeekDay = value),
                  ),
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
                            trainingBlock: trainingBlock!,
                            name: _exerciseDayNameController.text,
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
                            exerciseDay: widget.exerciseDay!,
                            trainingBlock: trainingBlock!,
                            name: _exerciseDayNameController.text,
                            weekDay: _selectedWeekDay,
                          );

                          setState(() => _isLoading = false);

                          pop();
                        },
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}