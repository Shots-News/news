import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/constant/constant.dart';

class MyCategoriesScreen extends StatefulWidget {
  const MyCategoriesScreen({Key? key}) : super(key: key);

  @override
  _MyCategoriesScreenState createState() => _MyCategoriesScreenState();
}

class _MyCategoriesScreenState extends State<MyCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Categories',
            style: style.h6BText(context),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
        ),
      ),
    );
  }
}
