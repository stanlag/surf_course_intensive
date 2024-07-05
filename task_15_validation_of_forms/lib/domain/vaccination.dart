import 'package:flutter/material.dart';
import 'field_name.dart';

class Vaccination {
  final String title;
  final FieldName fieldName;
  final TextEditingController textController;

  Vaccination({
    required this.title,
    required this.fieldName,
    required this.textController,
  });
}