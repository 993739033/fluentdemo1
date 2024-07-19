// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'T1Bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

T1Bean _$T1BeanFromJson(Map<String, dynamic> json) => T1Bean(
      (json['id'] as num).toInt(),
      json['name'] as String,
      (json['age'] as num).toInt(),
    );

Map<String, dynamic> _$T1BeanToJson(T1Bean instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'age': instance.age,
    };
