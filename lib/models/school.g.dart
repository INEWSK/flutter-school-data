// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SchoolAdapter extends TypeAdapter<School> {
  @override
  final int typeId = 1;

  @override
  School read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return School(
      a: fields[0] as String?,
      b: fields[1] as String?,
      c: fields[2] as String?,
      d: fields[3] as String?,
      e: fields[4] as String?,
      f: fields[5] as String?,
      g: fields[6] as String?,
      h: fields[7] as String?,
      i: fields[8] as String?,
      j: fields[9] as String?,
      k: fields[10] as String?,
      l: fields[11] as String?,
      m: fields[12] as String?,
      n: fields[13] as String?,
      o: fields[14] as String?,
      p: fields[15] as String?,
      q: fields[16] as String?,
      r: fields[17] as String?,
      s: fields[18] as String?,
      t: fields[19] as String?,
      u: fields[20] as String?,
      v: fields[21] as String?,
      w: fields[22] as String?,
      x: fields[23] as String?,
      y: fields[24] as String?,
      z: fields[25] as String?,
      aa: fields[26] as String?,
      ab: fields[27] as String?,
      ac: fields[28] as String?,
      ad: fields[29] as String?,
      ae: fields[30] as String?,
      af: fields[31] as String?,
      ag: fields[32] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, School obj) {
    writer
      ..writeByte(33)
      ..writeByte(0)
      ..write(obj.a)
      ..writeByte(1)
      ..write(obj.b)
      ..writeByte(2)
      ..write(obj.c)
      ..writeByte(3)
      ..write(obj.d)
      ..writeByte(4)
      ..write(obj.e)
      ..writeByte(5)
      ..write(obj.f)
      ..writeByte(6)
      ..write(obj.g)
      ..writeByte(7)
      ..write(obj.h)
      ..writeByte(8)
      ..write(obj.i)
      ..writeByte(9)
      ..write(obj.j)
      ..writeByte(10)
      ..write(obj.k)
      ..writeByte(11)
      ..write(obj.l)
      ..writeByte(12)
      ..write(obj.m)
      ..writeByte(13)
      ..write(obj.n)
      ..writeByte(14)
      ..write(obj.o)
      ..writeByte(15)
      ..write(obj.p)
      ..writeByte(16)
      ..write(obj.q)
      ..writeByte(17)
      ..write(obj.r)
      ..writeByte(18)
      ..write(obj.s)
      ..writeByte(19)
      ..write(obj.t)
      ..writeByte(20)
      ..write(obj.u)
      ..writeByte(21)
      ..write(obj.v)
      ..writeByte(22)
      ..write(obj.w)
      ..writeByte(23)
      ..write(obj.x)
      ..writeByte(24)
      ..write(obj.y)
      ..writeByte(25)
      ..write(obj.z)
      ..writeByte(26)
      ..write(obj.aa)
      ..writeByte(27)
      ..write(obj.ab)
      ..writeByte(28)
      ..write(obj.ac)
      ..writeByte(29)
      ..write(obj.ad)
      ..writeByte(30)
      ..write(obj.ae)
      ..writeByte(31)
      ..write(obj.af)
      ..writeByte(32)
      ..write(obj.ag);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SchoolAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
