import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/constant/colors.dart';
import 'package:news/constant/constant.dart';
import 'package:news/constant/dimensions.dart';
import 'package:news/locator.dart';
import 'package:news/services/firebase_auth.dart';
import 'package:news/views/widgets/button_widget.dart';

class MyAuthScreen extends StatelessWidget {
  const MyAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = locator<AuthService>();

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MyDimensions.width(context),
          height: MyDimensions.height(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Sign In',
                style: style.h4BText(context)!.copyWith(color: MyColors.red),
              ),
              Image.asset('assets/images/login.png'),
              AuthSocialButtonWidget(
                onTap: () {
                  authService.signInWIthGoogle();
                },
                color: MyColors.googleBlue,
                text: "Sign in with Google",
                imagePath: 'assets/images/google.png',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
