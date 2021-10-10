import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:white_rabbit_sreedwish/constants.dart';
import 'package:white_rabbit_sreedwish/dataResource/repository.dart';
import 'package:white_rabbit_sreedwish/models/user.dart';
import 'package:white_rabbit_sreedwish/uiResource/colors.dart';
import 'package:white_rabbit_sreedwish/uiResource/styles.dart';
import 'package:white_rabbit_sreedwish/views/widgets/list_item.dart';
import 'package:white_rabbit_sreedwish/views/widgets/loader.dart';

// ignore: use_key_in_widget_constructors
class UserListing extends StatefulWidget {
  @override
  _UserListingState createState() => _UserListingState();
}

class _UserListingState extends State<UserListing> {
  final _listStream = StreamController<List<User>?>.broadcast();
  final String _lblUsers = 'No Users Found!';
  final ScrollController sc = ScrollController();
  final Repository repository = Repository();
  bool searchMode = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      apiCall(null);
    });
  }

  /// This method is to load data from repository
  Future<void> apiCall(String? str) async {
    _listStream.sink.add(null);
    await Hive.openBox<User>(boxUsers);
    List<User> users = await repository.getUsers(str);
    _listStream.sink.add(users);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 16, right: 16, left: 16),
          padding: const EdgeInsets.only(bottom: 10),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              _userSearchWidget(),
              const SizedBox(
                height: 20,
              ),

              ///***** The list widget is wrapped with a stream builder
              /// user list coming as a stream from Repository ****
              Expanded(
                child: StreamBuilder<List<User>?>(
                    stream: _listStream.stream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container(
                          width: 40,
                          height: 40,
                          alignment: Alignment.center,
                          child: Loader(
                            key: UniqueKey(),
                          ),
                        );
                      }
                      if (snapshot.data!.isEmpty) {
                        return Container(
                          alignment: Alignment.center,
                          child: Text(
                            _lblUsers,
                            textAlign: TextAlign.center,
                            style: bodyText.copyWith(
                                color: const Color(textBlack), fontSize: 16),
                          ),
                        );
                      }

                      return ListView.separated(
                        controller: sc,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int i) {
                          return ListItemUser(
                            key: UniqueKey(),
                            user: snapshot.data![i],
                          );
                        },
                        separatorBuilder: (BuildContext context, int i) {
                          return const Divider(
                            thickness: 1,
                          );
                        },
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Search widget
  Widget _userSearchWidget() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: TextField(
        maxLines: 1,
        controller: _controller,
        autofocus: false,
        enabled: true,
        readOnly: false,
        onChanged: search,
        onSubmitted: searchSubmitted,
        decoration: InputDecoration(
            hintText: 'search users',
            hintStyle: regular.copyWith(fontSize: 14),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
            enabledBorder: normalBorder,
            border: normalBorder,
            fillColor: Colors.transparent,
            suffixIcon: GestureDetector(
              child: Icon(
                searchMode ? Icons.clear : Icons.youtube_searched_for_rounded,
                size: 20,
                color: searchMode ? const Color(errorRed) : Colors.black12,
              ),
              onTap: () {
                //if user is searching, then un focus and clear text
                if (searchMode) {
                  setState(() {
                    searchMode = !searchMode;
                  });

                  _controller.clear();

                  FocusScope.of(context).unfocus();

                  //Finally reset the list
                  searchSubmitted(null);
                }
              },
            )),
      ),
    );
  }

  /// callback for user input on text field
  void search(String? value) {
    if (value != null) {
      if (!searchMode) {
        setState(() {
          searchMode = true;
        });
      }
    }
  }

  ///Call back for text submit. Here the api is calling with search string
  void searchSubmitted(String? value) {
    apiCall(value);
  }

  @override
  void dispose() {
    _listStream.close();
    Hive.close();
    super.dispose();
  }
}
