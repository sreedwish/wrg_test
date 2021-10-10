import 'package:hive/hive.dart';
import 'package:white_rabbit_sreedwish/models/user.dart';
import 'package:white_rabbit_sreedwish/constants.dart';

class HiveBoxes {
  static Box<User> getUsers() => Hive.box(boxUsers);
}
