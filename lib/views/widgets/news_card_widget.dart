import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_const/flutter_const.dart';
import 'package:get_it/get_it.dart';
import 'package:news/constant/app_icons.dart';
import 'package:news/constant/colors.dart';
import 'package:news/constant/config.dart';
import 'package:news/constant/constant.dart';
import 'package:news/constant/dimensions.dart';
import 'package:news/utils/url_open.dart';
import 'package:news/utils/youtube.dart';
import 'package:news/views/widgets/widgets.dart';
import 'package:share/share.dart';

class NewsCardWidget extends StatefulWidget {
  const NewsCardWidget({
    Key? key,
    required this.title,
    required this.desc,
    this.image,
    this.video,
    required this.source,
    required this.isVideo,
  }) : super(key: key);

  final String title;
  final String desc;
  final String? image;
  final String? video;
  final String source;
  final bool isVideo;

  @override
  _NewsCardWidgetState createState() => _NewsCardWidgetState();
}

class _NewsCardWidgetState extends State<NewsCardWidget> {
  int maxLine = 10;

  @override
  Widget build(BuildContext context) {
    final youtubeConfig = GetIt.I<YoutubeConfig>();
    final widgets = GetIt.I<MyWidgets>();
    return Container(
      child: SingleChildScrollView(
        physics: maxLine == 10 ? NeverScrollableScrollPhysics() : AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.isVideo
                ? Container(
                    width: MyDimensions.width(context),
                    height: 200,
                    child: youtubeConfig.youtubeVideoPlayer(widget.video!),
                  )
                : AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image(
                      image: widgets.cacheImageProvider(MyConfig.baseImageUrl + widget.image!),
                      fit: BoxFit.fill,
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: style.subtitleBText(context)!.copyWith(wordSpacing: 2, height: 1.2),
                      textAlign: TextAlign.justify,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  fcHSizedBox1,
                  IconButton(
                    onPressed: () => Share.share('check out my website https://example.com', subject: 'Look what I made!'),
                    icon: Icon(
                      MyIcons.share,
                      size: 22,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: InkWell(
                onTap: () {
                  maxLine == 10 ? maxLine = 50 : maxLine = 10;
                  setState(() {});
                },
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Text(
                    widget.desc,
                    style: style.bodyText(context),
                    textAlign: TextAlign.justify,
                    maxLines: maxLine,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      openUrl(widget.source);
                    },
                    child: Text(
                      widget.isVideo ? 'You Tube' : 'Twitter',
                      style: style.bodyBText(context)!.copyWith(color: MyColors.white),
                    ),
                  ),
                  fcVSizedBox,
                  Text(
                    '12 days',
                    style: style.xSmallBText(context),
                  ),
                ],
              ),
            ),
            fcVSizedBox2,
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
