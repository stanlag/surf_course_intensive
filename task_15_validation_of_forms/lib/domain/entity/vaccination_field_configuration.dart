
import 'package:flutter/material.dart';

import 'field_name.dart';

class VaccinationFieldConfiguration {
  final String title;
  final FieldName fieldName;
  final TextEditingController textController;

  VaccinationFieldConfiguration({
    required this.title,
    required this.fieldName,
    required this.textController,
  });

  void dispose() {
    textController.dispose();
  }
}
