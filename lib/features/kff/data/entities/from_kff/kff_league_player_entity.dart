import 'package:equatable/equatable.dart';

class KffPlayerImageEntity extends Equatable {
  final String? original;
  final String? square;
  final String? thumb;
  final String? avatar;
  final String? content;

  const KffPlayerImageEntity({
    this.original,
    this.square,
    this.thumb,
    this.avatar,
    this.content,
  });

  factory KffPlayerImageEntity.fromJson(Map<String, dynamic> json) {
    return KffPlayerImageEntity(
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

class KffPlayerLineEntity extends Equatable {
  final int id;
  final String? title;

  const KffPlayerLineEntity({
    required this.id,
    this.title,
  });

  factory KffPlayerLineEntity.fromJson(Map<String, dynamic> json) {
    return KffPlayerLineEntity(
      id: json['id'],
      title: json['title'],
    );
  }

  @override
  List<Object?> get props => [id, title];
}

class KffLeaguePlayerEntity extends Equatable {
  final int id;
  final String? firstName;
  final String? lastName;
  final String? middleName;
  final String? birthday;
  final int? citizenshipId;
  final String? nationality;
  final int? height;
  final int? weight;
  final int? no;
  final String? description;
  final String? club;
  final int? games;
  final int? goals;
  final int? missedGoals;
  final dynamic birthdayTs; // может быть int или false
  final KffPlayerImageEntity? image;
  final KffPlayerLineEntity? line;

  const KffLeaguePlayerEntity({
    required this.id,
    this.firstName,
    this.lastName,
    this.middleName,
    this.birthday,
    this.citizenshipId,
    this.nationality,
    this.height,
    this.weight,
    this.no,
    this.description,
    this.club,
    this.games,
    this.goals,
    this.missedGoals,
    this.birthdayTs,
    this.image,
    this.line,
  });

  factory KffLeaguePlayerEntity.fromJson(Map<String, dynamic> json) {
    return KffLeaguePlayerEntity(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      middleName: json['middle_name'],
      birthday: json['birthday'],
      citizenshipId: json['citizenship_id'],
      nationality: json['nationality'],
      height: json['height'],
      weight: json['weight'],
      no: json['no'],
      description: json['description'],
      club: json['club'],
      games: json['games'],
      goals: json['goals'],
      missedGoals: json['missed_goals'],
      birthdayTs: json['birthday_ts'],
      image: json['image'] != null
          ? KffPlayerImageEntity.fromJson(json['image'])
          : null,
      line: json['line'] != null
          ? KffPlayerLineEntity.fromJson(json['line'])
          : null,
    );
  }

  /// Полное имя игрока
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

  /// Дата рождения из timestamp
  DateTime? get birthdayFromTimestamp {
    if (birthdayTs == null || birthdayTs == false) return null;
    if (birthdayTs is int) {
      return DateTime.fromMillisecondsSinceEpoch(birthdayTs * 1000);
    }
    return null;
  }

  /// Возраст игрока
  int? get age {
    final birthDate = birthdayDateTime ?? birthdayFromTimestamp;
    if (birthDate == null) return null;

    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  /// Рост в метрах
  double? get heightInMeters {
    if (height == null) return null;
    return height! / 100;
  }

  /// Статистика в текстовом виде
  String get statsDisplay {
    return 'Игр: ${games ?? 0}, Голов: ${goals ?? 0}';
  }

  /// Проверка позиции
  bool get isGoalkeeper =>
      line?.title?.toLowerCase().contains('вратарь') ?? false;
  bool get isDefender =>
      line?.title?.toLowerCase().contains('защитник') ?? false;
  bool get isMidfielder =>
      line?.title?.toLowerCase().contains('полузащитник') ?? false;
  bool get isForward =>
      line?.title?.toLowerCase().contains('нападающий') ?? false;

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        middleName,
        birthday,
        citizenshipId,
        nationality,
        height,
        weight,
        no,
        description,
        club,
        games,
        goals,
        missedGoals,
        birthdayTs,
        image,
        line,
      ];
}

class KffLeaguePlayerListEntity {
  static List<KffLeaguePlayerEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => KffLeaguePlayerEntity.fromJson(json))
        .toList();
  }
}
