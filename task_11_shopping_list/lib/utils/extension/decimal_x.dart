import 'package:decimal/decimal.dart';
import 'package:decimal/intl.dart';
import 'package:intl/intl.dart';

/// Расширение которое будет форматировать цену в денежный формат
extension DecimalX on Decimal {
  String toFormattedCurrency({String? symbol, int? decimalDigits}) {
    final currencyFormatter = NumberFormat.currency(
      locale: 'Ru_ru',
      symbol: symbol ?? 'руб',
      decimalDigits: decimalDigits ?? 0,
    );
    return currencyFormatter.format(DecimalIntl(this));
  }
}
