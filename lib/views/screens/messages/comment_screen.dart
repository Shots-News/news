import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_const/flutter_const.dart';
import 'package:news/constant/app_icons.dart';
import 'package:news/constant/colors.dart';
import 'package:news/constant/constant.dart';
import 'package:news/constant/dimensions.dart';

class MyCommentScreen extends StatelessWidget {
  const MyCommentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double bottomSize = 60;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Comments',
            style: style.h6BText(context),
          ),
        ),
        body: Container(
          width: double.infinity,
          height: MyDimensions.height(context),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: MyDimensions.height(context) - bottomSize,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: bottomSize),
                    ],
                  ),
                ),
              ),
              Container(
                height: bottomSize,
                color: MyColors.lightBlack,
                child: Row(
                  children: [
                    fcHSizedBox1,
                    Expanded(
                      child: TextField(
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Comment',
                        ),
                      ),
                    ),
                    fcHSizedBox1,
                    IconButton(
                      onPressed: () {},
                      icon: Icon(MyIcons.play_button),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
