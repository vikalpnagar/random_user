import 'package:random_user/models/coordinates.dart';
import 'package:random_user/models/street.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location {
  final String city;
  final String state;
  final String country;
  final String postcode;
  final Street street;
  final Coordinates coordinates;

  const Location(
      {this.city,
      this.state,
      this.country,
      this.postcode,
      this.street,
      this.coordinates});

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);

  get address {
    return "${street?.street ?? ''}, ${city ?? ''} ${state ?? ''}, ${country ?? ''} ${postcode ?? ''}";
  }
}
