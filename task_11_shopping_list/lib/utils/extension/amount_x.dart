import 'package:task_11_shopping_list/domain/entity/amount.dart';

extension AmountX on Amount {
  String getQuantityText() {
    if (this is Grams) {
      double kilograms = value / 1000;
      return '$kilograms кг';
    } else {
      return '$value шт';
    }
  }
}
