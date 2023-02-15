import 'package:flutter/material.dart';

import '../../widgets/exercise_day.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ExerciseDay(name: 'Push 1');
  }
}
