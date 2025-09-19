import 'package:equatable/equatable.dart';

/// Какая платформа дергается (по базовому URL из твоего клиента)
enum NewsPlatform { yii, laravel }

/// Параметры запроса для /news на обеих платформах.
/// - Общие: page, per_page, order
/// - Yii: category, type, front
/// - Laravel: championship_id, people_id, command_id, fix
class GetNewsParameter extends Equatable {
  final NewsPlatform platform;
  final int page;
  final int perPage;
  final String order; // latest | desc | oldest | asc
  final String? acceptLanguage; // kk | ru | en | kk-KZ | ru-RU | en-US

  // Yii
  final String? category;
  final int? type;
  final String? front; // true/1/yes/on

  // Laravel
  final int? championshipId;
  final int? peopleId;
  final int? commandId;
  final String? fix; // true/1/yes/on

  const GetNewsParameter({
    required this.platform,
    this.page = 1,
    this.perPage = 25,
    this.order = 'latest',
    this.acceptLanguage,
    // Yii
    this.category,
    this.type,
    this.front,
    // Laravel
    this.championshipId,
    this.peopleId,
    this.commandId,
    this.fix,
  });

  /// Сформировать query map только с релевантными ключами для выбранной платформы
  Map<String, dynamic> toQuery() {
    final base = <String, dynamic>{
      'page': page,
      'per_page': perPage,
      'order': order,
    };

    switch (platform) {
      case NewsPlatform.yii:
        return {
          ...base,
          if (category != null) 'category': category,
          if (type != null) 'type': type,
          if (front != null) 'front': front,
        };
      case NewsPlatform.laravel:
        return {
          ...base,
          if (championshipId != null) 'championship_id': championshipId,
          if (peopleId != null) 'people_id': peopleId,
          if (commandId != null) 'command_id': commandId,
          if (fix != null) 'fix': fix,
        };
    }
  }

  GetNewsParameter copyWith({
    NewsPlatform? platform,
    int? page,
    int? perPage,
    String? order,
    String? acceptLanguage,
    String? category,
    int? type,
    String? front,
    int? championshipId,
    int? peopleId,
    int? commandId,
    String? fix,
  }) {
    return GetNewsParameter(
      platform: platform ?? this.platform,
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
      order: order ?? this.order,
      acceptLanguage: acceptLanguage ?? this.acceptLanguage,
      category: category ?? this.category,
      type: type ?? this.type,
      front: front ?? this.front,
      championshipId: championshipId ?? this.championshipId,
      peopleId: peopleId ?? this.peopleId,
      commandId: commandId ?? this.commandId,
      fix: fix ?? this.fix,
    );
  }

  @override
  List<Object?> get props => [
    platform,
    page,
    perPage,
    order,
    acceptLanguage,
    category,
    type,
    front,
    championshipId,
    peopleId,
    commandId,
    fix,
  ];
}