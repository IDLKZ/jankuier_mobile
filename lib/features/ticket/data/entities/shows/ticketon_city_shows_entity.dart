import 'package:equatable/equatable.dart';

class TicketonShowsCityEntity extends Equatable {
  final int? id;
  final String? tag;
  final String? name;

  const TicketonShowsCityEntity({
    this.id,
    this.tag,
    this.name,
  });

  factory TicketonShowsCityEntity.fromJson(Map<String, dynamic> json) {
    return TicketonShowsCityEntity(
      id: int.tryParse(json['id']?.toString() ?? ''),
      tag: json['tag'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (tag != null) 'tag': tag,
      if (name != null) 'name': name,
    };
  }

  @override
  List<Object?> get props => [id, tag, name];
}
