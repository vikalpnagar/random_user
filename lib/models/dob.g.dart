// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dob.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DOB _$DOBFromJson(Map<String, dynamic> json) {
  return DOB(
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    age: json['age'] as int,
  );
}

Map<String, dynamic> _$DOBToJson(DOB instance) => <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'age': instance.age,
    };
