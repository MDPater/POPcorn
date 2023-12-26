// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'needtowatch.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class needtowatchAdapter extends TypeAdapter<needtowatch> {
  @override
  final int typeId = 2;

  @override
  needtowatch read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return needtowatch(
      movieTitle: fields[0] as String,
      movieID: fields[3] as int,
      star: fields[2] as dynamic,
      posterurl: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, needtowatch obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.movieTitle)
      ..writeByte(1)
      ..write(obj.posterurl)
      ..writeByte(2)
      ..write(obj.star)
      ..writeByte(3)
      ..write(obj.movieID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is needtowatchAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
