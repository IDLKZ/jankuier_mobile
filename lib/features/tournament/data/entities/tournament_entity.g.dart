// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournament_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TournamentEntityAdapter extends TypeAdapter<TournamentEntity> {
  @override
  final int typeId = 1;

  @override
  TournamentEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TournamentEntity(
      id: fields[0] as int,
      name: fields[1] as String,
      createdAt: fields[2] as String,
      updatedAt: fields[3] as String,
      isInternational: fields[4] as bool,
      image: fields[5] as String?,
      showInStats: fields[6] as bool,
      lastFullCalculatedAt: fields[7] as String?,
      isMale: fields[8] as bool,
      sport: fields[9] as int?,
      seasons: (fields[10] as List).cast<SeasonEntity>(),
    );
  }

  @override
  void write(BinaryWriter writer, TournamentEntity obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.updatedAt)
      ..writeByte(4)
      ..write(obj.isInternational)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.showInStats)
      ..writeByte(7)
      ..write(obj.lastFullCalculatedAt)
      ..writeByte(8)
      ..write(obj.isMale)
      ..writeByte(9)
      ..write(obj.sport)
      ..writeByte(10)
      ..write(obj.seasons);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TournamentEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SeasonEntityAdapter extends TypeAdapter<SeasonEntity> {
  @override
  final int typeId = 2;

  @override
  SeasonEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SeasonEntity(
      id: fields[0] as int,
      name: fields[1] as String,
      startDate: fields[2] as DateTime,
      endDate: fields[3] as DateTime,
      teams: (fields[4] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, SeasonEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.startDate)
      ..writeByte(3)
      ..write(obj.endDate)
      ..writeByte(4)
      ..write(obj.teams);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SeasonEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
