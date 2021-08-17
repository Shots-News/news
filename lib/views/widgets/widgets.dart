import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/constant/config.dart';
import 'package:shimmer/shimmer.dart';

class MyExpandedWidget extends StatelessWidget {
  const MyExpandedWidget({
    Key? key,
    this.child,
    this.color,
  }) : super(key: key);

  final Widget? child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      child: child,
      color: color,
    ));
  }
}

class MyWidgets {
  Widget cacheImage(String url) {
    return CachedNetworkImage(
      imageUrl: MyConfig.baseImageUrl + url,
      fit: BoxFit.fill,
      errorWidget: (context, url, error) => myShimmer(),
      progressIndicatorBuilder: (context, url, downloadProgress) => myShimmer(),
    );
  }
}

Widget myShimmer() {
  return SizedBox(
    child: Shimmer.fromColors(
      baseColor: Colors.white30,
      highlightColor: Color(0xFFF4F4F4),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          width: double.infinity,
          height: 100,
          color: Colors.green[50],
        ),
      ),
    ),
  );
}
