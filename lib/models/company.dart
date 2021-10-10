import 'package:hive_flutter/hive_flutter.dart';

part 'company.g.dart';

@HiveType(typeId: 2)
class Company extends HiveObject {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? catchPhrase;
  @HiveField(2)
  String? bs;

  Company({this.name, this.catchPhrase, this.bs});

  Company.fromJson(dynamic json) {
    name = json["name"];
    catchPhrase = json["catchPhrase"];
    bs = json["bs"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = name;
    map["catchPhrase"] = catchPhrase;
    map["bs"] = bs;
    return map;
  }
}
