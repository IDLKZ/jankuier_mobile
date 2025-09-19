import 'package:hive/hive.dart';
import '../common/entities/file_entity.dart';

class FileEntityAdapter extends TypeAdapter<FileEntity> {
  @override
  final int typeId = 3;

  @override
  FileEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FileEntity(
      id: fields[0] as int,
      filename: fields[1] as String,
      filePath: fields[2] as String,
      fileSize: fields[3] as int,
      contentType: fields[4] as String,
      isRemote: fields[5] as bool,
      createdAt: fields[6] as DateTime,
      updatedAt: fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, FileEntity obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.filename)
      ..writeByte(2)
      ..write(obj.filePath)
      ..writeByte(3)
      ..write(obj.fileSize)
      ..writeByte(4)
      ..write(obj.contentType)
      ..writeByte(5)
      ..write(obj.isRemote)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FileEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}