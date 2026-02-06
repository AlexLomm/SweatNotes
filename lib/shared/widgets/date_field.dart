import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final ValueChanged<DateTime>? onDateSelected;
  final DateTime selectedDate;

  const DateField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.onDateSelected,
    required this.selectedDate,
  });

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
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
      onChanged: (value) {
        if (value != null) widget.onDateSelected?.call(value);
      },
      value: widget.selectedDate,
      mode: DateTimeFieldPickerMode.date,
      materialDatePickerOptions: MaterialDatePickerOptions(
        initialDatePickerMode: DatePickerMode.day,
      ),
      dateFormat: DateFormat.yMMMMd('en_US'),
    );
  }
}
