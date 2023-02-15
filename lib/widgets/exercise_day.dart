import 'package:flutter/material.dart';

class ExerciseDay extends StatelessWidget {
  const ExerciseDay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 126,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(103, 80, 164, 0.08),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: Container(),
    );
  }
}
