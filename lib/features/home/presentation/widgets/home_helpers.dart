String formatDate(String dateString) {
  try {
    // Преобразуем строку в объект DateTime.
    final dateTime = DateTime.parse(dateString);

    // Получаем день, месяц и год из объекта DateTime.
    // padLeft(2, '0') добавляет ведущий ноль, если число состоит из одной цифры (например, 7 -> 07).
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final year = dateTime.year;

    // Собираем строку в нужном формате.
    return "$day.$month.$year";
  } catch (e) {
    // Если строка не соответствует формату, возвращаем её без изменений.
    return dateString;
  }
}

String formatNewsDate(String dateString) {
  try {
    final dateTime = DateTime.parse(dateString);
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} дн. назад';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ч. назад';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} мин. назад';
    } else {
      return 'Только что';
    }
  } catch (e) {
    return dateString;
  }
}