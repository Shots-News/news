import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_const/flutter_const.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:news/constant/app_icons.dart';
import 'package:news/constant/colors.dart';
import 'package:news/views/screens/messages/comment_screen.dart';

class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget({
    Key? key,
    required FlutterTts flutterTts,
    required this.description,
  })  : _flutterTts = flutterTts,
        super(key: key);

  final FlutterTts _flutterTts;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 10),
      color: MyColors.lightBlack,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.bookmarks_outlined),
              fcHSizedBox2,
              InkWell(
                onTap: () async {
                  await _flutterTts.speak(description);
                },
                child: Icon(MyIcons.megaphone),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              FcNavigator().push(context, screen: MyCommentScreen());
            },
            child: Icon(MyIcons.inbox),
          ),
        ],
      ),
    );
  }
}
