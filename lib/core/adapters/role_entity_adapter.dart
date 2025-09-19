import 'package:hive/hive.dart';
import '../../features/auth/data/entities/role_entity.dart';
import '../../features/auth/data/entities/permission_entity.dart';

class RoleEntityAdapter extends TypeAdapter<RoleEntity> {
  @override
  final int typeId = 5;

  @override
  RoleEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RoleEntity(
      id: fields[0] as int,
      titleRu: fields[1] as String,
      titleKk: fields[2] as String,
      titleEn: fields[3] as String?,
      descriptionRu: fields[4] as String?,
      descriptionKk: fields[5] as String?,
      descriptionEn: fields[6] as String?,
      value: fields[7] as String,
      isActive: fields[8] as bool,
      canRegister: fields[9] as bool,
      isSystem: fields[10] as bool,
      isAdministrative: fields[11] as bool,
      createdAt: fields[12] as DateTime,
      updatedAt: fields[13] as DateTime,
      deletedAt: fields[14] as DateTime?,
      permissions: (fields[15] as List?)?.cast<PermissionEntity>() ?? [],
    );
  }

  @override
  void write(BinaryWriter writer, RoleEntity obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.titleRu)
      ..writeByte(2)
      ..write(obj.titleKk)
      ..writeByte(3)
      ..write(obj.titleEn)
      ..writeByte(4)
      ..write(obj.descriptionRu)
      ..writeByte(5)
      ..write(obj.descriptionKk)
      ..writeByte(6)
      ..write(obj.descriptionEn)
      ..writeByte(7)
      ..write(obj.value)
      ..writeByte(8)
      ..write(obj.isActive)
      ..writeByte(9)
      ..write(obj.canRegister)
      ..writeByte(10)
      ..write(obj.isSystem)
      ..writeByte(11)
      ..write(obj.isAdministrative)
      ..writeByte(12)
      ..write(obj.createdAt)
      ..writeByte(13)
      ..write(obj.updatedAt)
      ..writeByte(14)
      ..write(obj.deletedAt)
      ..writeByte(15)
      ..write(obj.permissions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoleEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}