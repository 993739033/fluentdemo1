
import 'package:json_annotation/json_annotation.dart';

part 'T1Bean.g.dart';

//dart run build_runner build
@JsonSerializable()
class T1Bean{
    int id;
    String name;
    int age;

    T1Bean(this.id, this.name, this.age);

    factory T1Bean.fromJson(Map<String, dynamic> json) =>
        _$T1BeanFromJson(json);

    Map<String, dynamic> toJson() => _$T1BeanToJson(this);
}