import 'package:equatable/equatable.dart';

/// Параметры запроса для /news/{id} на обеих платформах.
/// - Общие: id
class GetNewOneParameter extends Equatable {

  final int id;
  final String? acceptLanguage; // kk | ru | en | kk-KZ | ru-RU | en-US

  const GetNewOneParameter({
    required this.id,
    this.acceptLanguage
  });

  /// Сформировать query map только с релевантными ключами для выбранной платформы
  Map<String, dynamic> toQuery() {
    final base = <String, dynamic>{
      'id': id,
    };

    if (acceptLanguage != null) {
      base['accept-language'] = acceptLanguage;
    }

    return base;
  }

  GetNewOneParameter copyWith({
    int? id,
    String? acceptLanguage,
  }) {
    return GetNewOneParameter(
      id: id ?? this.id,
      acceptLanguage: acceptLanguage ?? this.acceptLanguage,
    );
  }

  @override
  List<Object?> get props => [
    id,
    acceptLanguage,
  ];
}