import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_const/flutter_const.dart';
import 'package:news/constant/colors.dart';
import 'package:news/views/screens/start/introduction_screen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration(seconds: 5), () {
      FcNavigator().pushReplacement(context, screen: OnBoardingPage());
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: MyColors.lightBlack,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/splash2.png',
              fit: BoxFit.cover,
              width: 300,
            ),
            Column(
              children: [
                Text(
                  'News App',
                  style: FcTextStyle().h5BText(context),
                ),
                fcVSizedBox,
                Text(
                  'Read Every News Fast and Free',
                  style: FcTextStyle().bodyText(context),
                ),
                fcVSizedBox2,
              ],
            )
          ],
        ),
      ),
    );
  }
}
