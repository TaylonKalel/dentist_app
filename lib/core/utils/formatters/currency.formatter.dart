import 'package:intl/intl.dart';

class CurrencyPtBrInputFormatter {
  static currencyFormatter(double? text) {
    final formatter =
        NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$', decimalDigits: 2);
    if (text == null) return formatter.format(0.00);
    return formatter.format(text);
  }
}
