import 'package:task_15_validation_of_forms/assets/res/app_strings.dart';
import 'package:task_15_validation_of_forms/assets/res/app_images.dart';

/// Вид питомца
enum TypeOfPet {
  dog(AppStrings.dog, AppImages.dog),
  cat(AppStrings.cat, AppImages.cat),
  parrot(AppStrings.parrot, AppImages.parrot),
  hamster(AppStrings.hamster, AppImages.hamster);

  final String text;
  final String image;

  const TypeOfPet(this.text, this.image);
}
