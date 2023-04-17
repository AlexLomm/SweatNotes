import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final ValueChanged<DateTime>? onDateSelected;
  final DateTime selectedDate;

  const DateField({
    Key? key,
    required this.labelText,
    required this.hintText,
    this.onDateSelected,
    required this.selectedDate,
  }) : super(key: key);

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  @override
  Widget build(BuildContext context) {
    return DateTimeField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceVariant,
        labelText: widget.labelText,
        hintText: widget.hintText,
        suffixIcon: const Icon(Icons.calendar_month),
      ),
      dateTextStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
      onDateSelected: widget.onDateSelected,
      initialDate: widget.selectedDate,
      selectedDate: widget.selectedDate,
      initialDatePickerMode: DatePickerMode.day,
      mode: DateTimeFieldPickerMode.date,
      initialTimePickerEntryMode: TimePickerEntryMode.input,
      dateFormat: DateFormat.yMMMMd('en_US'),
    );
  }
}
