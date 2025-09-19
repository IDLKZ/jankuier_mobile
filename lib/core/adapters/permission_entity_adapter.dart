import 'package:hive/hive.dart';
import '../../features/auth/data/entities/permission_entity.dart';

class PermissionEntityAdapter extends TypeAdapter<PermissionEntity> {
  @override
  final int typeId = 4;

  @override
  PermissionEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PermissionEntity(
      id: fields[0] as int,
      titleRu: fields[1] as String,
      titleKk: fields[2] as String?,
      titleEn: fields[3] as String?,
      value: fields[4] as String,
      createdAt: fields[5] as DateTime,
      updatedAt: fields[6] as DateTime,
      deletedAt: fields[7] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, PermissionEntity obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.titleRu)
      ..writeByte(2)
      ..write(obj.titleKk)
      ..writeByte(3)
      ..write(obj.titleEn)
      ..writeByte(4)
      ..write(obj.value)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.updatedAt)
      ..writeByte(7)
      ..write(obj.deletedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PermissionEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}