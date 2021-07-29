import 'package:flutter/cupertino.dart';
import 'package:news/constant/constant.dart';

class AuthSocialButtonWidget extends StatelessWidget {
  const AuthSocialButtonWidget({
    Key? key,
    required this.onTap,
    required this.color,
    this.textColor,
    required this.text,
    required this.imagePath,
  }) : super(key: key);

  final Function() onTap;
  final Color color;
  final Color? textColor;
  final String text;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(imagePath, width: 35),
              Text(text, style: style.h6BText(context)),
            ],
          ),
        ),
      ),
    );
  }
}
