import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:white_rabbit_sreedwish/models/address.dart';
import 'package:white_rabbit_sreedwish/models/company.dart';
import 'package:white_rabbit_sreedwish/models/geo.dart';
import 'package:white_rabbit_sreedwish/models/user.dart';

import 'package:white_rabbit_sreedwish/constants.dart';
import 'package:white_rabbit_sreedwish/uiResource/routes.dart';
import 'package:white_rabbit_sreedwish/views/screens/user_details.dart';
import 'package:white_rabbit_sreedwish/views/screens/users_listing.dart';
import 'models/geo.dart';

void main() async {
  //Hive database used to store data
  //It has to initialize first
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(CompanyAdapter());
  Hive.registerAdapter(AddressAdapter());
  Hive.registerAdapter(GeoAdapter());

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child1) {
        return MediaQuery(
          child: child1 ??
              const Scaffold(
                body: Text('WRG Test App by Sreedwish'),
              ),
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        );
      },
      initialRoute: routeHome,
      routes: {
        routeHome: (BuildContext context) => UserListing(),
        routeExpansion: (BuildContext context) => UserDetails(),
      },
    );
  }
}
