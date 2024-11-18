// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watchedmovie.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class watchedmovieAdapter extends TypeAdapter<watchedmovie> {
  @override
  final int typeId = 1;

  @override
  watchedmovie read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return watchedmovie(
      movieTitle: fields[0] as String,
      posterurl: fields[1] as String,
      starRating: fields[3] as double,
      movieID: fields[4] as int,
      comment: fields[2] as String,
      movieWatchedAt: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, watchedmovie obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.movieTitle)
      ..writeByte(1)
      ..write(obj.posterurl)
      ..writeByte(2)
      ..write(obj.comment)
      ..writeByte(3)
      ..write(obj.starRating)
      ..writeByte(4)
      ..write(obj.movieID)
      ..writeByte(5)
      ..write(obj.movieWatchedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is watchedmovieAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
