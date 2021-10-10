import 'package:hive_flutter/hive_flutter.dart';

part 'geo.g.dart';

@HiveType(typeId: 4)
class Geo extends HiveObject{
  @HiveField(0)
  String? lat;
  @HiveField(1)
  String? lng;

  Geo({this.lat, this.lng});

  Geo.fromJson(dynamic json) {
    lat = json["lat"];
    lng = json["lng"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["lat"] = lat;
    map["lng"] = lng;
    return map;
  }
}
