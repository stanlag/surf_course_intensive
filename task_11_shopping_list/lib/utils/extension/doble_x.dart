// Расширение которое будет форматировать цену в денежный формат
import 'package:decimal/decimal.dart';
import 'package:task_11_shopping_list/utils/extension/decimal_x.dart';

extension DoubleX on double {
  String doubleToDecimalToFormattedCurrency() {
    Decimal price = Decimal.parse(toString());
    return price.toFormattedCurrency();
  }
}
