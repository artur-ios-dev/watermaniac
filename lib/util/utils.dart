class Utils {
  static bool isToday(DateTime date) {
    var today = DateTime.now();

    if (date.year == today.year &&
        date.month == today.month &&
        date.day == today.day) {
      return true;
    }

    return false;
  }

  static String formatNumberWithShortcuts(double number, int maxFractionDigits) {
    var thousandsNum = number / 1000;
    var millionNum = number / 1000000;

    if (number >= 1000 && number < 1000000) {
      return '${thousandsNum.toStringAsFixed(maxFractionDigits)}k';
    }

    if (number >= 1000000) {
      return '${millionNum.toStringAsFixed(maxFractionDigits)}M';
    }

    return number.toStringAsFixed(maxFractionDigits);
  }
}
