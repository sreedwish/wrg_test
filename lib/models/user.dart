import 'package:hive_flutter/hive_flutter.dart';

import 'address.dart';
import 'company.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0)
  late int id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? username;
  @HiveField(3)
  String? email;
  @HiveField(4)
  String? profileImage;
  @HiveField(5)
  Address? address;
  @HiveField(6)
  String? phone;
  @HiveField(7)
  String? website;
  @HiveField(8)
  Company? company;

  User(
      {required this.id,
      this.name,
      this.username,
      this.email,
      this.profileImage,
      this.address,
      this.phone,
      this.website,
      this.company});

  User.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
    username = json["username"];
    email = json["email"];
    profileImage = json["profile_image"];
    address =
        json["address"] != null ? Address.fromJson(json["address"]) : null;
    phone = json["phone"];
    website = json["website"];
    company =
        json["company"] != null ? Company.fromJson(json["company"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["username"] = username;
    map["email"] = email;
    map["profile_image"] = profileImage;
    if (address != null) {
      map["address"] = address!.toJson();
    }
    map["phone"] = phone;
    map["website"] = website;
    if (company != null) {
      map["company"] = company!.toJson();
    }
    return map;
  }
}
