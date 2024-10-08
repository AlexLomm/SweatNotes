import 'package:flutter/material.dart';

import '../shared/widgets/regular_text_field.dart';

class DisplayNameField extends StatelessWidget {
  final TextEditingController controller;

  const DisplayNameField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return RegularTextField(
      controller: controller,
      maxLength: 30,
      labelText: 'Display name',
      hintText: 'Enter your display name',
    );
  }
}
