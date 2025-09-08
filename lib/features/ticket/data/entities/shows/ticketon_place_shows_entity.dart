import 'package:equatable/equatable.dart';

class TicketonShowsPlaceEntity extends Equatable {
  final String? id;
  final String? name;
  final String? nameFull;
  final String? address;
  final int? cityId;
  final bool? isActive;
  final String? remark;
  final String? description;
  final List<dynamic>? images;
  final String? main;

  const TicketonShowsPlaceEntity({
    this.id,
    this.name,
    this.nameFull,
    this.address,
    this.cityId,
    this.isActive,
    this.remark,
    this.description,
    this.images,
    this.main,
  });

  factory TicketonShowsPlaceEntity.fromJson(Map<String, dynamic> json) {
    return TicketonShowsPlaceEntity(
      id: json['id']?.toString(),
      name: json['name'],
      nameFull: json['namefull'],
      address: json['address'],
      cityId: int.tryParse(json['city_id']?.toString() ?? ''),
      isActive: json['is_active'] == '1' || json['is_active'] == 1,
      remark: json['remark'],
      description: json['description'],
      images: json['images'],
      main: json['main'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (nameFull != null) 'namefull': nameFull,
      if (address != null) 'address': address,
      if (cityId != null) 'city_id': cityId,
      if (isActive != null) 'is_active': isActive! ? '1' : '0',
      if (remark != null) 'remark': remark,
      if (description != null) 'description': description,
      if (images != null) 'images': images,
      if (main != null) 'main': main,
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        nameFull,
        address,
        cityId,
        isActive,
        remark,
        description,
        images,
        main
      ];
}
