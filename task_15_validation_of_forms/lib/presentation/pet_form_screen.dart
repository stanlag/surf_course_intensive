import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_15_validation_of_forms/assets/colors/app_color.dart';
import 'package:task_15_validation_of_forms/domain/field_name.dart';
import 'package:task_15_validation_of_forms/utils/extension/data_time_x.dart';
import 'package:task_15_validation_of_forms/assets/res/app_strings.dart';
import 'package:task_15_validation_of_forms/model_provider/pets_model.dart';
import 'package:task_15_validation_of_forms/utils/my_data_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_15_validation_of_forms/domain/type_of_pet.dart';
import 'package:task_15_validation_of_forms/domain/vaccination.dart';

class PetFormScreen extends StatelessWidget {
  const PetFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final petsModel = context.watch<PetsModel>();
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 40),
            const _ChoosingAPetsWidget(),
            Form(
              key: petsModel.formKey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Поле для имени питомца
                    _FormFieldWidget(
                      label: AppStrings.petName,
                      validator: (value) {
                        if (value == null ||
                            value.trim().length < 3 ||
                            value.trim().length > 20) {
                          petsModel.updateField(
                              fieldName: FieldName.petName, value: value);
                          return AppStrings.petNameValidation;
                        }
                        return null;
                      },
                    ),
                    // Поле для даты рождения питомца
                    _DateFormFieldWidget(
                      label: AppStrings.birthDate,
                      validator: (value) {
                        return (value == null || value.trim() == '')
                            ? AppStrings.birthDateValidation
                            : null;
                      },
                      onTap: () async {
                        DateTime pickedDate =
                            await myDataPicker(context) as DateTime;
                        petsModel.birthDateOnDateTime = pickedDate;
                        petsModel.updateField(
                            fieldName: FieldName.birthDate,
                            value: pickedDate.toStringDateAndTime());
                      },
                      controller:
                          TextEditingController(text: petsModel.birthDate),
                    ),
                    // Поле для веса питомца
                    _FormFieldWidget(
                      label: AppStrings.weight,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppStrings.weightValidationEmpty;
                        }
                        final parsedValue = double.tryParse(value);
                        if (parsedValue == null || parsedValue <= 0) {
                          return AppStrings.weightValidationInvalid;
                        }
                        petsModel.updateField(
                            fieldName: FieldName.weight, value: parsedValue);
                        return null;
                      },
                    ),
                    // Поле для электронной почты хозяина
                    _FormFieldWidget(
                      label: AppStrings.ownerEmail,
                      validator: (value) {
                        if (value == null ||
                            !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                          petsModel.updateField(
                              fieldName: FieldName.email, value: value);
                          return AppStrings.ownerEmailValidation;
                        }
                        return null;
                      },
                    ),
                    // Условное отображение чекбоксов прививок
                    petsModel.selectedIndexPet == 0 ||
                            petsModel.selectedIndexPet == 1
                        ? const CheckboxListVaccinationsWidget()
                        : const SizedBox.shrink(),
                    // Кнопка сохранения
                    const ElevateButtonWidget(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Виджет для выбора питомца
class _ChoosingAPetsWidget extends StatelessWidget {
  const _ChoosingAPetsWidget();

  @override
  Widget build(BuildContext context) {
    final modelPets = context.watch<PetsModel>();

    return GridView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.all(10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            modelPets.setSelectedIndex(index);
          },
          child: _PetWidget(
            iconPath: TypeOfPet.values[index].image,
            petName: TypeOfPet.values[index].text,
            backgroundColor: modelPets.selectedIndexPet == index
                ? AppColor.red
                : AppColor.white,
            foregroundColor: modelPets.selectedIndexPet == index
                ? AppColor.white
                : AppColor.black,
          ),
        );
      },
    );
  }
}

/// Виджет для отображения питомца
class _PetWidget extends StatelessWidget {
  const _PetWidget(
      {required this.iconPath,
      required this.petName,
      required this.backgroundColor,
      required this.foregroundColor});
  final String iconPath;
  final String petName;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: backgroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SvgPicture.asset(
              iconPath,
              // ignore: deprecated_member_use
              color: foregroundColor,
            ),
          ),
        ),
        const SizedBox(height: 5),
        // TODO: Исправить отступы чтобы не было ошибки
        Text(
          petName,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

/// Кнопка для сохранения формы
class ElevateButtonWidget extends StatelessWidget {
  const ElevateButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final petsModel = context.watch<PetsModel>();
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            petsModel.submitForm(context);
          },
          child: const Text(AppStrings.saveButton),
        ),
      ),
    );
  }
}

/// Общий виджет с настройками формы для ввода
class _BaseFormFieldWidget extends StatelessWidget {
  final String label;
  final TextInputType? keyboardType;
  final String? Function(String?) validator;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final bool readOnly;

  const _BaseFormFieldWidget({
    required this.label,
    required this.validator,
    this.keyboardType,
    this.controller,
    this.onTap,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColor.grey),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          filled: true,
          isCollapsed: true,
          labelText: label,
          labelStyle: const TextStyle(color: AppColor.darkGrey),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: AppColor.transparent),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: AppColor.transparent),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(top: 10),
        ),
        validator: validator,
        onTap: onTap,
        readOnly: readOnly,
      ),
    );
  }
}

/// Виджет для ввода текста
class _FormFieldWidget extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final String? Function(String?) validator;

  const _FormFieldWidget({
    required this.label,
    required this.validator,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return _BaseFormFieldWidget(
      label: label,
      keyboardType: keyboardType,
      validator: validator,
    );
  }
}

/// Виджет для поля ввода даты
class _DateFormFieldWidget extends StatelessWidget {
  final String label;
  final String? Function(String?) validator;
  final TextEditingController controller;
  final VoidCallback onTap;

  const _DateFormFieldWidget({
    required this.label,
    required this.validator,
    required this.controller,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return _BaseFormFieldWidget(
      label: label,
      controller: controller,
      validator: validator,
      onTap: onTap,
      readOnly: true,
    );
  }
}

/// Виджет для отображения списка прививок
class CheckboxListVaccinationsWidget extends StatelessWidget {
  const CheckboxListVaccinationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final petsModel = context.watch<PetsModel>();
    final vaccinations = [
      Vaccination(
        title: AppStrings.rabies,
        fieldName: FieldName.rabies,
        textController: TextEditingController(text: petsModel.rabies),
      ),
      Vaccination(
        title: AppStrings.covid,
        fieldName: FieldName.covid,
        textController: TextEditingController(text: petsModel.covid),
      ),
      Vaccination(
        title: AppStrings.malaria,
        fieldName: FieldName.malaria,
        textController: TextEditingController(text: petsModel.malaria),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.vaccinationTitle,
              style: Theme.of(context).textTheme.titleLarge),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: vaccinations.length,
            itemBuilder: (context, index) {
              final vaccination = vaccinations[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: VaccinationCheckbox(
                  title: vaccination.title,
                  child: _DateFormFieldWidget(
                    label: AppStrings.vaccinationDateLabel,
                    onTap: () async {
                      DateTime pickedDate =
                      await myDataPicker(context) as DateTime;
                      petsModel.vaccinationDateOnDateTime = pickedDate;
                      petsModel.updateField(
                        fieldName: vaccination.fieldName,
                        value: pickedDate.toStringDateAndTime(),
                      );
                    },
                    validator: (value) {
                      if (value == null || value.trim() == '') {
                        return AppStrings.vaccinationDateValidationEmpty;
                      }
                      if (petsModel.birthDateOnDateTime.millisecondsSinceEpoch >
                          petsModel.vaccinationDateOnDateTime
                              .millisecondsSinceEpoch) {
                        return AppStrings.vaccinationDateValidationInvalid;
                      }
                      return null;
                    },
                    controller: vaccination.textController,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Чекбокс для каждой прививки с полем ввода даты
class VaccinationCheckbox extends StatefulWidget {
  final String title;
  final Widget child;

  const VaccinationCheckbox(
      {required this.title, required this.child, super.key});

  @override
  State<VaccinationCheckbox> createState() => _VaccinationCheckboxState();
}

class _VaccinationCheckboxState extends State<VaccinationCheckbox> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Checkbox(
              value: _isChecked,
              onChanged: (bool? value) {
                setState(() {
                  _isChecked = value ?? false;
                });
              }, // Цвет отметки
            ),
            Text(widget.title),
          ],
        ),
        if (_isChecked)
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: widget.child,
          ),
      ],
    );
  }
}
