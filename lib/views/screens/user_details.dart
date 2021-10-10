// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:white_rabbit_sreedwish/models/address.dart';
import 'package:white_rabbit_sreedwish/models/company.dart';
import 'package:white_rabbit_sreedwish/models/user.dart';
import 'package:white_rabbit_sreedwish/uiResource/colors.dart';
import 'package:white_rabbit_sreedwish/uiResource/styles.dart';
import 'package:white_rabbit_sreedwish/views/widgets/line_item.dart';
import 'package:white_rabbit_sreedwish/views/widgets/map_widget.dart';
import 'package:white_rabbit_sreedwish/views/widgets/title_item.dart';

import '../../constants.dart';

class UserDetails extends StatelessWidget {
  late final User user;
  final List<Widget> widgets = [];

  @override
  Widget build(BuildContext context) {
    var params = ModalRoute.of(context)!.settings.arguments as List;

    user = params[0];

    String profileImg = user.profileImage ?? '';
    String name = user.name ?? unknown;

    widgets.add(CircleAvatar(
      radius: MediaQuery.of(context).size.width * 0.15,
      backgroundImage: const AssetImage(avatar),
      foregroundImage: profileImg.isEmpty ? null : NetworkImage(profileImg),
      backgroundColor: const Color(colorPrimary),
    ));
    widgets.add(const SizedBox(height: 10));
    widgets.add(FittedBox(
      child: Text(
        name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: headline1Black.copyWith(
            fontSize: 20, color: const Color(textBlack)),
      ),
      alignment: Alignment.topLeft,
    ));
    widgets.add(const Divider());
    widgets.add(Container(
        alignment: Alignment.topLeft,
        child: const TitleItem(title: 'User Details')));
    widgets.addAll(extractUserDetails());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(colorPrimary),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(" "),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(20),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              children: widgets,
            ),
          ),
        ),
      ),
    );
  }

  /// In this method, the user object is getting iterated and data converted to
  /// widgets then getting added to the main widget list
  List<Widget> extractUserDetails() {
    List<Widget> widgets = [];

    user.toJson().forEach((key, value) {
      if (key == 'address') {
        //Do nothing
      } else if (key == 'company') {
        widgets.add(const Divider());

        widgets.add(Container(
            alignment: Alignment.topLeft,
            child: const TitleItem(title: 'Company Details')));

        Company? company = user.company;

        company!.toJson().forEach((key, value) {
          LineItem lineItem = LineItem(hint: key, value: value);
          widgets.add(lineItem);
        });
      } else {
        if (value != user.profileImage) {
          LineItem lineItem = LineItem(hint: key, value: value.toString());
          widgets.add(lineItem);
        }
      }
    });

    Address? address = user.address;

    if (address != null) {
      widgets.add(const Divider());

      widgets.add(Container(
          alignment: Alignment.topLeft,
          child: const TitleItem(title: 'Address')));

      widgets.add(MapWidget(address: address));

      address.toJson().forEach((key, value) {
        if (key != 'geo') {
          LineItem lineItem = LineItem(hint: key, value: value.toString());
          widgets.add(lineItem);
        }
      });
    }

    return widgets;
  }
}
