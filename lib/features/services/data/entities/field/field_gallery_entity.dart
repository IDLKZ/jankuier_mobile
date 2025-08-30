import 'package:equatable/equatable.dart';
import '../../../../../core/common/entities/file_entity.dart';
import 'field_entity.dart';
import 'field_party_entity.dart';

class FieldGalleryEntity extends Equatable {
  final int id;
  final int fieldId;
  final int? partyId;
  final int? fileId;

  final DateTime createdAt;
  final DateTime updatedAt;

  final FieldEntity? field;
  final FieldPartyEntity? party;
  final FileEntity? file;

  const FieldGalleryEntity({
    required this.id,
    required this.fieldId,
    this.partyId,
    this.fileId,
    required this.createdAt,
    required this.updatedAt,
    this.field,
    this.party,
    this.file,
  });

  factory FieldGalleryEntity.fromJson(Map<String, dynamic> json) {
    return FieldGalleryEntity(
      id: json['id'],
      fieldId: json['field_id'],
      partyId: json['party_id'],
      fileId: json['file_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      field: json['field'] != null ? FieldEntity.fromJson(json['field']) : null,
      party: json['party'] != null
          ? FieldPartyEntity.fromJson(json['party'])
          : null,
      file: json['file'] != null ? FileEntity.fromJson(json['file']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'field_id': fieldId,
      'party_id': partyId,
      'file_id': fileId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'field': field?.toJson(),
      'party': party?.toJson(),
      'file': file?.toJson(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        fieldId,
        partyId,
        fileId,
        createdAt,
        updatedAt,
        field,
        party,
        file,
      ];
}

class FieldGalleryListEntity {
  static List<FieldGalleryEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => FieldGalleryEntity.fromJson(json)).toList();
  }
}
