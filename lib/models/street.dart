import 'package:json_annotation/json_annotation.dart';

part 'street.g.dart';

@JsonSerializable()
class Street {
  final int number;
  final String name;

  const Street({this.number, this.name});

  factory Street.fromJson(Map<String, dynamic> json) => _$StreetFromJson(json);

  Map<String, dynamic> toJson() => _$StreetToJson(this);

  get street => "${number?.toString() ?? ''} ${name ?? ''}";
}
