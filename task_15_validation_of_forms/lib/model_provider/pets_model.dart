import 'package:flutter/material.dart';
import 'package:task_15_validation_of_forms/assets/res/app_strings.dart';
import 'package:task_15_validation_of_forms/domain/entity/field_name.dart';

import '../domain/entity/field_value.dart';

class PetsModel extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int selectedIndexPet = 0;
  DateTime birthDateOnDateTime = DateTime.now();
  DateTime vaccinationDateOnDateTime = DateTime.now();

  String? _petName;
  String? _birthDate;
  double? _weight;
  String? _email;

  // прививки
  String? _rabies;
  String? _covid;
  String? _malaria;

  // Геттеры для получения значений полей
  String get petName => _petName ?? '';
  String get birthDate => _birthDate ?? '';
  double get weight => _weight ?? 0.0;
  String get email => _email ?? '';
  String get rabies => _rabies ?? '';
  String get covid => _covid ?? '';
  String get malaria => _malaria ?? '';

  void setSelectedIndex(int index) {
    selectedIndexPet = index;
    notifyListeners();
  }

  /// Метод для обновления значений полей и валидации формы
  // void updateField({required FieldName fieldName, required dynamic value}) {
  //   switch (fieldName) {
  //     case FieldName.petName:
  //       _petName = (value as String).trim();
  //       break;
  //     case FieldName.birthDate:
  //       _birthDate = value as String;
  //       break;
  //     case FieldName.weight:
  //       _weight = value as double;
  //       break;
  //     case FieldName.email:
  //       _email = (value as String).trim();
  //       break;
  //     case FieldName.rabies:
  //       _rabies = value as String;
  //       break;
  //     case FieldName.covid:
  //       _covid = value as String;
  //       break;
  //     case FieldName.malaria:
  //       _malaria = value as String;
  //       break;
  //     default:
  //       throw ArgumentError(AppStrings.errorNameField);
  //   }
  //
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     notifyListeners();
  //   });
  // }

  void updateField({required FieldName fieldName, required FieldValue value}) {
    switch (fieldName) {
      case FieldName.petName:
      case FieldName.email:
      case FieldName.rabies:
      case FieldName.covid:
      case FieldName.malaria:
        _updateStringField(fieldName, value);
        break;
      case FieldName.birthDate:
        _updateStringField(fieldName, value);
        break;
      case FieldName.weight:
        _updateDoubleField(fieldName, value);
        break;
      default:
        throw ArgumentError(AppStrings.errorNameField);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void _updateStringField(FieldName fieldName, FieldValue value) {
    if (value is StringFieldValue) {
      final stringValue = value.value.trim();
      switch (fieldName) {
        case FieldName.petName:
          _petName = stringValue;
          break;
        case FieldName.email:
          _email = stringValue;
          break;
        case FieldName.rabies:
          _rabies = stringValue;
          break;
        case FieldName.covid:
          _covid = stringValue;
          break;
        case FieldName.malaria:
          _malaria = stringValue;
          break;
        case FieldName.birthDate:
          _birthDate = stringValue;
          break;
        default:
          throw ArgumentError(AppStrings.errorNameField);
      }
    } else {
      throw ArgumentError(AppStrings.errorNameField);
    }
  }

  void _updateDoubleField(FieldName fieldName, FieldValue value) {
    if (value is DoubleFieldValue) {
      final doubleValue = value.value;
      if (fieldName == FieldName.weight) {
        _weight = doubleValue;
      } else {
        throw ArgumentError(AppStrings.errorNameField);
      }
    } else {
      throw ArgumentError(AppStrings.errorNameField);
    }
  }




  /// Метод для подтверждения формы
  void submitForm(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.formSubmitted)),
      );
    }
  }
}
