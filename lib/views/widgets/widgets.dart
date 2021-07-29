import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
      imageUrl: url,
      placeholder: (context, url) => MyExpandedWidget(
        color: Colors.grey[50],
      ),
      errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
      progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
    );
  }

  ImageProvider cacheImageProvider(String url, {int? maxHeight, int? maxWidth}) {
    return CachedNetworkImageProvider(url, maxHeight: maxHeight, maxWidth: maxWidth);
  }
}
