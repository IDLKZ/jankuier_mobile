/// Утилита для форматирования цен с разделением тысяч
class PriceFormatter {
  /// Форматирует цену с разделением тысяч пробелами
  ///
  /// Примеры:
  /// - 1000.00 -> "1 000"
  /// - 1000.56 -> "1 000.56"
  /// - 13000 -> "13 000"
  /// - 130000 -> "130 000"
  /// - 1300000 -> "1 300 000"
  ///
  /// Если дробная часть .00 или .0, то она убирается
  /// Если дробная часть > .00, то она выводится
  static String format(dynamic price) {
    if (price == null) return '0';

    // Конвертируем в double
    double priceValue;
    if (price is String) {
      priceValue = double.tryParse(price) ?? 0;
    } else if (price is int) {
      priceValue = price.toDouble();
    } else if (price is double) {
      priceValue = price;
    } else {
      return '0';
    }

    // Разделяем на целую и дробную части
    int integerPart = priceValue.truncate();
    double fractionalPart = priceValue - integerPart;

    // Форматируем целую часть с разделением тысяч
    String formattedInteger = _formatWithThousandsSeparator(integerPart);

    // Проверяем дробную часть
    // Если дробная часть равна 0 (или очень близка к 0), не выводим её
    if (fractionalPart.abs() < 0.001) {
      return formattedInteger;
    }

    // Иначе выводим дробную часть
    // Округляем до 2 знаков после запятой
    String fractionalString = fractionalPart.toStringAsFixed(2).substring(2);

    return '$formattedInteger.$fractionalString';
  }

  /// Форматирует число с разделением тысяч пробелами
  static String _formatWithThousandsSeparator(int number) {
    String numStr = number.abs().toString();
    String result = '';

    int count = 0;
    for (int i = numStr.length - 1; i >= 0; i--) {
      if (count == 3) {
        result = ' $result';
        count = 0;
      }
      result = numStr[i] + result;
      count++;
    }

    return number < 0 ? '-$result' : result;
  }

  /// Форматирует цену с добавлением валюты
  ///
  /// Примеры:
  /// - formatWithCurrency(1000.00, 'KZT') -> "1 000 KZT"
  /// - formatWithCurrency(1000.56, '₸') -> "1 000.56 ₸"
  static String formatWithCurrency(dynamic price, String currency) {
    String formattedPrice = format(price);
    return '$formattedPrice $currency';
  }
}
