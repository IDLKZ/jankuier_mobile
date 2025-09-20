import 'package:equatable/equatable.dart';

class KffCoachImageEntity extends Equatable {
  final String? original;
  final String? square;
  final String? thumb;
  final String? avatar;
  final String? content;

  const KffCoachImageEntity({
    this.original,
    this.square,
    this.thumb,
    this.avatar,
    this.content,
  });

  factory KffCoachImageEntity.fromJson(Map<String, dynamic> json) {
    return KffCoachImageEntity(
      original: json['original'],
      square: json['square'],
      thumb: json['thumb'],
      avatar: json['avatar'],
      content: json['content'],
    );
  }

  @override
  List<Object?> get props => [original, square, thumb, avatar, content];
}

class KffLeagueCoachEntity extends Equatable {
  final int id;
  final String? firstName;
  final String? lastName;
  final String? middleName;
  final String? title;
  final String? nationality;
  final String? license;
  final String? birthday;
  final String? description;
  final KffCoachImageEntity? image;

  const KffLeagueCoachEntity({
    required this.id,
    this.firstName,
    this.lastName,
    this.middleName,
    this.title,
    this.nationality,
    this.license,
    this.birthday,
    this.description,
    this.image,
  });

  factory KffLeagueCoachEntity.fromJson(Map<String, dynamic> json) {
    return KffLeagueCoachEntity(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      middleName: json['middle_name'],
      title: json['title'],
      nationality: json['nationality'],
      license: json['license'],
      birthday: json['birthday'],
      description: json['description'],
      image: json['image'] != null
          ? KffCoachImageEntity.fromJson(json['image'])
          : null,
    );
  }

  /// Полное имя тренера
  String get fullName {
    final parts = [firstName, middleName, lastName]
        .where((part) => part != null && part.isNotEmpty)
        .toList();
    return parts.join(' ');
  }

  /// Парсинг даты рождения
  DateTime? get birthdayDateTime {
    if (birthday == null || birthday!.isEmpty) return null;
    try {
      return DateTime.parse(birthday!);
    } catch (e) {
      return null;
    }
  }

  /// Возраст тренера
  int? get age {
    final birthDate = birthdayDateTime;
    if (birthDate == null) return null;

    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  /// Проверка на главного тренера
  bool get isHeadCoach {
    return title?.toLowerCase().contains('главный') ?? false;
  }

  /// Проверка на ассистента
  bool get isAssistant {
    return title?.toLowerCase().contains('ассистент') ?? false;
  }

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        middleName,
        title,
        nationality,
        license,
        birthday,
        description,
        image,
      ];
}

class KffLeagueCoachListEntity {
  static List<KffLeagueCoachEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => KffLeagueCoachEntity.fromJson(json)).toList();
  }
}
