// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UsersEntityAdapter extends TypeAdapter<UsersEntity> {
  @override
  final int typeId = 0;

  @override
  UsersEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UsersEntity(
      page: fields[0] as int?,
      perPage: fields[1] as int?,
      total: fields[2] as int?,
      totalPages: fields[3] as int?,
      data: (fields[4] as List?)?.cast<UserData>(),
    );
  }

  @override
  void write(BinaryWriter writer, UsersEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.page)
      ..writeByte(1)
      ..write(obj.perPage)
      ..writeByte(2)
      ..write(obj.total)
      ..writeByte(3)
      ..write(obj.totalPages)
      ..writeByte(4)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsersEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
