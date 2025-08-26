import 'package:equatable/equatable.dart';

class RefereesEntity extends Equatable {
  final String? main;
  final String? firstAssistant;
  final String? secondAssistant;
  final String? fourthReferee;
  final String? videoAssistant1;
  final String? videoAssistantMain;
  final String? matchInspector;

  const RefereesEntity({
    this.main,
    this.firstAssistant,
    this.secondAssistant,
    this.fourthReferee,
    this.videoAssistant1,
    this.videoAssistantMain,
    this.matchInspector,
  });

  factory RefereesEntity.fromJson(Map<String, dynamic> json) {
    return RefereesEntity(
      main: json['main'],
      firstAssistant: json['1st_assistant'],
      secondAssistant: json['2nd_assistant'],
      fourthReferee: json['4th_referee'],
      videoAssistant1: json['video_assistant_1'],
      videoAssistantMain: json['video_assistant_main'],
      matchInspector: json['match_inspector'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'main': main,
      '1st_assistant': firstAssistant,
      '2nd_assistant': secondAssistant,
      '4th_referee': fourthReferee,
      'video_assistant_1': videoAssistant1,
      'video_assistant_main': videoAssistantMain,
      'match_inspector': matchInspector,
    };
  }

  @override
  List<Object?> get props => [
        main,
        firstAssistant,
        secondAssistant,
        fourthReferee,
        videoAssistant1,
        videoAssistantMain,
        matchInspector,
      ];
}

class CoachEntity extends Equatable {
  final String firstName;
  final List<String> lastName;

  const CoachEntity({
    required this.firstName,
    required this.lastName,
  });

  factory CoachEntity.fromJson(Map<String, dynamic> json) {
    return CoachEntity(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] != null ? List<String>.from(json['last_name']) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
    };
  }

  String get fullName => '$firstName ${lastName.join(' ')}';

  @override
  List<Object?> get props => [firstName, lastName];
}

class LineupPlayerEntity extends Equatable {
  final String id;
  final int number;
  final String fullName;
  final String lastName;
  final bool isGk;
  final bool isCaptain;
  final String? basImagePath;

  const LineupPlayerEntity({
    required this.id,
    required this.number,
    required this.fullName,
    required this.lastName,
    required this.isGk,
    required this.isCaptain,
    this.basImagePath,
  });

  factory LineupPlayerEntity.fromJson(Map<String, dynamic> json) {
    return LineupPlayerEntity(
      id: json['id'] ?? '',
      number: json['number'] ?? 0,
      fullName: json['full_name'] ?? '',
      lastName: json['last_name'] ?? '',
      isGk: json['is_gk'] ?? false,
      isCaptain: json['is_captain'] ?? false,
      basImagePath: json['bas_image_path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'number': number,
      'full_name': fullName,
      'last_name': lastName,
      'is_gk': isGk,
      'is_captain': isCaptain,
      'bas_image_path': basImagePath,
    };
  }

  @override
  List<Object?> get props => [
        id,
        number,
        fullName,
        lastName,
        isGk,
        isCaptain,
        basImagePath,
      ];
}

class TeamLineupEntity extends Equatable {
  final String id;
  final String name;
  final String shortName;
  final String? basLogoPath;
  final String brandColor;
  final CoachEntity coach;
  final CoachEntity firstAssistant;
  final CoachEntity secondAssistant;
  final List<dynamic> coaches; // Empty array in your example
  final List<LineupPlayerEntity> lineup;

  const TeamLineupEntity({
    required this.id,
    required this.name,
    required this.shortName,
    this.basLogoPath,
    required this.brandColor,
    required this.coach,
    required this.firstAssistant,
    required this.secondAssistant,
    required this.coaches,
    required this.lineup,
  });

  factory TeamLineupEntity.fromJson(Map<String, dynamic> json) {
    return TeamLineupEntity(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      shortName: json['short_name'] ?? '',
      basLogoPath: json['bas_logo_path'],
      brandColor: json['brand_color'] ?? '',
      coach: CoachEntity.fromJson(json['coach'] ?? {}),
      firstAssistant: CoachEntity.fromJson(json['first_assistant'] ?? {}),
      secondAssistant: CoachEntity.fromJson(json['second_assistant'] ?? {}),
      coaches: json['coaches'] != null ? List<dynamic>.from(json['coaches']) : [],
      lineup: json['lineup'] != null 
          ? (json['lineup'] as List<dynamic>)
              .map((playerJson) => LineupPlayerEntity.fromJson(playerJson))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'short_name': shortName,
      'bas_logo_path': basLogoPath,
      'brand_color': brandColor,
      'coach': coach.toJson(),
      'first_assistant': firstAssistant.toJson(),
      'second_assistant': secondAssistant.toJson(),
      'coaches': coaches,
      'lineup': lineup.map((player) => player.toJson()).toList(),
    };
  }

  // Helper methods
  List<LineupPlayerEntity> get goalkeepers {
    return lineup.where((player) => player.isGk).toList();
  }

  List<LineupPlayerEntity> get outfieldPlayers {
    return lineup.where((player) => !player.isGk).toList();
  }

  LineupPlayerEntity? get captain {
    try {
      return lineup.firstWhere((player) => player.isCaptain);
    } catch (e) {
      return null;
    }
  }

  @override
  List<Object?> get props => [
        id,
        name,
        shortName,
        basLogoPath,
        brandColor,
        coach,
        firstAssistant,
        secondAssistant,
        coaches,
        lineup,
      ];
}

class MatchLineupEntity extends Equatable {
  final String date;
  final RefereesEntity referees;
  final TeamLineupEntity homeTeam;
  final TeamLineupEntity awayTeam;

  const MatchLineupEntity({
    required this.date,
    required this.referees,
    required this.homeTeam,
    required this.awayTeam,
  });

  factory MatchLineupEntity.fromJson(Map<String, dynamic> json) {
    return MatchLineupEntity(
      date: json['date'] ?? '',
      referees: RefereesEntity.fromJson(json['referees'] ?? {}),
      homeTeam: TeamLineupEntity.fromJson(json['home_team'] ?? {}),
      awayTeam: TeamLineupEntity.fromJson(json['away_team'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'referees': referees.toJson(),
      'home_team': homeTeam.toJson(),
      'away_team': awayTeam.toJson(),
    };
  }

  @override
  List<Object?> get props => [date, referees, homeTeam, awayTeam];
}
