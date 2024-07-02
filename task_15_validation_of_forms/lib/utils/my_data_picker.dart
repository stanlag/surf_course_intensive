import 'package:flutter/material.dart';

Future<DateTime?> myDataPicker(BuildContext context) async {
  FocusScope.of(context).requestFocus(FocusNode());
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime.now(),
  );
  if (pickedDate != null) {
    return pickedDate;
  }
  return null;
}
