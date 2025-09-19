import 'package:equatable/equatable.dart';

/// Универсальная модель новости для kff.kz (Yii) и kffleague.kz (Laravel).
/// Нормализует ключевые различия:
/// - Дата: datetime/datetime_iso (Laravel) vs shown_date_ts/shown_date (Yii)
/// - Просмотры: views (Laravel) vs views_cnt (Yii)
/// - Картинка: объект ImageUrls или строка-URL
class News extends Equatable {
  final int id;
  final String title;

  final String? slug;
  /// Краткое описание (Yii: teaser)
  final String? summary;
  /// Полный текст (Laravel: text)
  final String? text;

  /// Нормализованная дата публикации (если возможно распарсить)
  final DateTime? date;

  /// Кол-во просмотров (views/views_cnt)
  final int? views;

  /// Закреплена (Laravel: fix == 1)
  final bool pinned;

  /// Категория (Yii: {title, slug})
  final String? categoryTitle;
  final String? categorySlug;

  /// Нормализованный URL картинки (original > content > square > thumb > avatar, или строка как есть)
  final String? imageUrl;

  /// Каноническая ссылка на материал, если есть
  final String? link;

  const News({
    required this.id,
    required this.title,
    this.slug,
    this.summary,
    this.text,
    this.date,
    this.views,
    this.pinned = false,
    this.categoryTitle,
    this.categorySlug,
    this.imageUrl,
    this.link,
  });

  /// Создание из JSON (поддерживает как Yii, так и Laravel).
  factory News.fromJson(Map<String, dynamic> json) {
    final date = _parseDate(json);
    final views = _parseViews(json);
    final pinned = _parsePinned(json);
    final imageUrl = _pickImageUrl(json['image']);

    String? categoryTitle;
    String? categorySlug;
    final cat = json['category'];
    if (cat is Map<String, dynamic>) {
      categoryTitle = cat['title']?.toString();
      categorySlug = cat['slug']?.toString();
    }

    return News(
      id: _asInt(json['id']),
      title: (json['title'] ?? '').toString(),
      slug: json['slug']?.toString(),
      summary: json['teaser']?.toString(), // Yii
      text: json['text']?.toString(),      // Laravel
      date: date,
      views: views,
      pinned: pinned,
      categoryTitle: categoryTitle,
      categorySlug: categorySlug,
      imageUrl: imageUrl,
      link: json['link']?.toString(),
    );
  }

  /// Обратно в JSON (без потери — только нормализованные поля этой модели).
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'slug': slug,
    'summary': summary,
    'text': text,
    'date': date?.toIso8601String(),
    'views': views,
    'pinned': pinned,
    'categoryTitle': categoryTitle,
    'categorySlug': categorySlug,
    'imageUrl': imageUrl,
    'link': link,
  };

  News copyWith({
    int? id,
    String? title,
    String? slug,
    String? summary,
    String? text,
    DateTime? date,
    int? views,
    bool? pinned,
    String? categoryTitle,
    String? categorySlug,
    String? imageUrl,
    String? link,
  }) {
    return News(
      id: id ?? this.id,
      title: title ?? this.title,
      slug: slug ?? this.slug,
      summary: summary ?? this.summary,
      text: text ?? this.text,
      date: date ?? this.date,
      views: views ?? this.views,
      pinned: pinned ?? this.pinned,
      categoryTitle: categoryTitle ?? this.categoryTitle,
      categorySlug: categorySlug ?? this.categorySlug,
      imageUrl: imageUrl ?? this.imageUrl,
      link: link ?? this.link,
    );
  }

  /// Удобный маппер списка
  static List<News> listFromJson(List<dynamic> arr) =>
      arr.map((e) => News.fromJson((e as Map).cast<String, dynamic>())).toList();

  @override
  List<Object?> get props => [
    id,
    title,
    slug,
    summary,
    text,
    date,
    views,
    pinned,
    categoryTitle,
    categorySlug,
    imageUrl,
    link,
  ];

  // ---------- helpers ----------

  static int _asInt(Object? v) {
    if (v is int) return v;
    if (v is String) return int.tryParse(v) ?? 0;
    return 0;
  }

  static DateTime? _parseDate(Map<String, dynamic> json) {
    // Laravel: datetime (UNIX seconds) / datetime_iso (ISO)
    final dtIso = json['datetime_iso']?.toString();
    if (dtIso != null && dtIso.isNotEmpty) {
      final parsed = DateTime.tryParse(dtIso);
      if (parsed != null) return parsed.toLocal();
    }
    final dtUnix = _asInt(json['datetime']);
    if (dtUnix > 0) {
      return DateTime.fromMillisecondsSinceEpoch(dtUnix * 1000, isUtc: true).toLocal();
    }

    // Yii: shown_date_ts (UNIX seconds) / shown_date (string)
    final shownTs = _asInt(json['shown_date_ts']);
    if (shownTs > 0) {
      return DateTime.fromMillisecondsSinceEpoch(shownTs * 1000, isUtc: true).toLocal();
    }
    final shown = json['shown_date']?.toString();
    if (shown != null && shown.isNotEmpty) {
      // Попытка стандартного парсинга ISO/YYYY-MM-DD
      final parsed = DateTime.tryParse(shown);
      if (parsed != null) return parsed.toLocal();
    }
    return null;
    // Если формат экзотический, парсить с кастомным регэкспом — по мере необходимости.
  }

  static int? _parseViews(Map<String, dynamic> json) {
    final v1 = json['views'];
    final v2 = json['views_cnt'];
    int? toInt(Object? v) {
      if (v == null) return null;
      if (v is int) return v;
      if (v is String) return int.tryParse(v);
      return null;
    }

    return toInt(v1) ?? toInt(v2);
  }

  static bool _parsePinned(Map<String, dynamic> json) {
    final v = json['fix'];
    if (v == null) return false;
    if (v is bool) return v;
    if (v is num) return v == 1;
    if (v is String) {
      final sv = v.toLowerCase();
      return sv == '1' || sv == 'true' || sv == 'yes' || sv == 'on';
    }
    return false;
  }

  /// Выбор лучшего URL картинки из разных форматов ответа
  static String? _pickImageUrl(dynamic image) {
    if (image == null) return null;
    if (image is String) {
      return image.isEmpty ? null : image;
    }
    if (image is Map) {
      final m = image.cast<String, dynamic>();
      String? pick(String key) => m[key]?.toString().isEmpty ?? true ? null : m[key]?.toString();
      return pick('original') ??
          pick('content') ??
          pick('square') ??
          pick('thumb') ??
          pick('avatar');
    }
    return null;
  }
}
