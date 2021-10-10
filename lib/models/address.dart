import 'package:hive_flutter/hive_flutter.dart';
import 'package:white_rabbit_sreedwish/models/geo.dart';

part 'address.g.dart';

@HiveType(typeId: 3)
class Address extends HiveObject{
  @HiveField(0)
  String? street;
  @HiveField(1)
  String? suite;
  @HiveField(2)
  String? city;
  @HiveField(3)
  String? zipcode;
  @HiveField(4)
  Geo? geo;

  Address({this.street, this.suite, this.city, this.zipcode, this.geo});

  Address.fromJson(dynamic json) {
    street = json["street"];
    suite = json["suite"];
    city = json["city"];
    zipcode = json["zipcode"];
    geo = json["geo"] != null ? Geo.fromJson(json["geo"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["street"] = street;
    map["suite"] = suite;
    map["city"] = city;
    map["zipcode"] = zipcode;
    if (geo != null) {
      map["geo"] = geo!.toJson();
    }
    return map;
  }
}
