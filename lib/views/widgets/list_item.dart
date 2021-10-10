// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:white_rabbit_sreedwish/constants.dart';
import 'package:white_rabbit_sreedwish/models/user.dart';
import 'package:white_rabbit_sreedwish/uiResource/colors.dart';
import 'package:white_rabbit_sreedwish/uiResource/routes.dart';
import 'package:white_rabbit_sreedwish/uiResource/styles.dart';
import 'package:white_rabbit_sreedwish/utils/logger.dart';

class ListItemUser extends StatelessWidget {
  final User user;
  ListItemUser({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double spaceSize = MediaQuery.of(context).size.width * 0.02;
    double sizedBox = (width * 0.1);
    double iconSize = sizedBox * 0.5;

    String profileImg = user.profileImage ?? '';
    String name = user.name ?? unknown;
    String company =
        (user.company) == null ? unknown : (user.company!.name) ?? unknown;

    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(top: 6, bottom: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.055,
              backgroundImage: const AssetImage(avatar),
              foregroundImage:
                  profileImg.isEmpty ? null : NetworkImage(profileImg),
              backgroundColor: const Color(colorPrimary),
            ),

            SizedBox(width: MediaQuery.of(context).size.width * 0.038),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    child: Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: headline1Black.copyWith(
                          fontSize: 16, color: const Color(textBlack2)),
                    ),
                    alignment: Alignment.topLeft,
                  ),
                  const SizedBox(height: 2),
                  FittedBox(
                    child: Text(
                      company,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: subTitle.copyWith(
                          fontSize: 14, color: const Color(textSubGrey)),
                    ),
                    alignment: Alignment.topLeft,
                  ),
                ],
              ),
            ),

            SizedBox(
              width: spaceSize,
            ),
            //Message Button
            SizedBox(
              width: sizedBox,
              height: sizedBox,
              child: IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_right,
                  color: const Color(colorPrimary),
                  size: iconSize,
                ),
                onPressed: () {
                  onExpanded(context);
                },
              ),
            )
          ],
        ),
      ),
      onTap: () {
        onExpanded(context);
      },
    );
  }

  void onExpanded(BuildContext context) {
    Navigator.pushNamed(context, routeExpansion, arguments: [user]);
  }
}
