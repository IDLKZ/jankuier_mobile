import 'package:hive/hive.dart';
import '../../features/auth/data/entities/user_entity.dart';
import '../../features/auth/data/entities/role_entity.dart';
import '../common/entities/file_entity.dart';

class UserEntityAdapter extends TypeAdapter<UserEntity> {
  @override
  final int typeId = 6;

  @override
  UserEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserEntity(
      id: fields[0] as int,
      roleId: fields[1] as int?,
      imageId: fields[2] as int?,
      firstName: fields[3] as String,
      lastName: fields[4] as String,
      patronomic: fields[5] as String?,
      email: fields[6] as String,
      phone: fields[7] as String,
      username: fields[8] as String,
      sex: fields[9] as int?,
      iin: fields[10] as String?,
      birthdate: fields[11] as DateTime?,
      isActive: fields[12] as bool,
      isVerified: fields[13] as bool,
      createdAt: fields[14] as DateTime,
      updatedAt: fields[15] as DateTime,
      deletedAt: fields[16] as DateTime?,
      role: fields[17] as RoleEntity?,
      image: fields[18] as FileEntity?,
    );
  }

  @override
  void write(BinaryWriter writer, UserEntity obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.roleId)
      ..writeByte(2)
      ..write(obj.imageId)
      ..writeByte(3)
      ..write(obj.firstName)
      ..writeByte(4)
      ..write(obj.lastName)
      ..writeByte(5)
      ..write(obj.patronomic)
      ..writeByte(6)
      ..write(obj.email)
      ..writeByte(7)
      ..write(obj.phone)
      ..writeByte(8)
      ..write(obj.username)
      ..writeByte(9)
      ..write(obj.sex)
      ..writeByte(10)
      ..write(obj.iin)
      ..writeByte(11)
      ..write(obj.birthdate)
      ..writeByte(12)
      ..write(obj.isActive)
      ..writeByte(13)
      ..write(obj.isVerified)
      ..writeByte(14)
      ..write(obj.createdAt)
      ..writeByte(15)
      ..write(obj.updatedAt)
      ..writeByte(16)
      ..write(obj.deletedAt)
      ..writeByte(17)
      ..write(obj.role)
      ..writeByte(18)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}