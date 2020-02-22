import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dob.g.dart';

@JsonSerializable()
class DOB {
  final DateTime date;
  final int age;

  const DOB({this.date, this.age});

  factory DOB.fromJson(Map<String, dynamic> json) => _$DOBFromJson(json);

  Map<String, dynamic> toJson() => _$DOBToJson(this);

  get dateTimeWithAge => date != null
      ? "${DateFormat('dd/MM/yyyy hh:mm').format(date)}, Age: ${age ?? '--'}"
      : '--';
}
