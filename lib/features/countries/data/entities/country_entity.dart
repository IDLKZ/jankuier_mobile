import 'package:equatable/equatable.dart';

import '../../../../core/common/entities/sota_pagination_entity.dart';

class CountryEntity extends Equatable {
  final int id;
  final String name;
  final String flagImage;
  final String code;

  const CountryEntity({
    required this.id,
    required this.name,
    required this.flagImage,
    required this.code,
  });

  factory CountryEntity.fromJson(Map<String, dynamic> json) {
    return CountryEntity(
      id: json['id'],
      name: json['name'],
      flagImage: json['flag_image'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'flag_image': flagImage,
      'code': code,
    };
  }

  @override
  List<Object?> get props => [id, name, flagImage, code];
}
