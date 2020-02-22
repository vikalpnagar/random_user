import 'package:random_user/models/location.dart';
import 'package:random_user/models/name.dart';
import 'package:random_user/models/picture.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'dob.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String gender;
  final Name name;
  final String email;
  final DOB dob;
  final String phone;
  final String cell;
  final Picture picture;
  final Location location;

  User({
    @required this.gender,
    @required this.name,
    @required this.email,
    @required this.dob,
    @required this.phone,
    @required this.cell,
    @required this.picture,
    @required this.location,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
