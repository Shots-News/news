import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_const/flutter_const.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:news/constant/app_icons.dart';
import 'package:news/constant/colors.dart';
import 'package:news/constant/constant.dart';
import 'package:news/locator.dart';
import 'package:news/models/article_model.dart';
import 'package:news/routes/navigation_service.dart';
import 'package:news/utils/date_time_formatter.dart';
import 'package:news/utils/youtube.dart';
import 'package:news/views/screens/home/web_view.dart';
import 'package:news/views/screens/messages/commentArgs.dart';
import 'package:news/views/screens/messages/comment_screen.dart';
import 'package:news/views/widgets/widgets.dart';
import 'package:share/share.dart';

class NewsCardWidget extends StatefulWidget {
  const NewsCardWidget({
    Key? key,
    required this.articalModel,
  }) : super(key: key);

  final ArticleModel articalModel;

  @override
  _NewsCardWidgetState createState() => _NewsCardWidgetState();
}

class _NewsCardWidgetState extends State<NewsCardWidget> {
  bool lines = true;
  bool speak = true;
  final _flutterTts = FlutterTts();

  @override
  void initState() {
    _flutterTts.setLanguage('en');
    _flutterTts.setSpeechRate(0.4);
    _flutterTts.setVolume(1);
    super.initState();
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        physics: lines ? NeverScrollableScrollPhysics() : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: widget.articalModel.isVideo!
                    ? locator<YoutubeConfig>().youtubeVideoPlayer(widget.articalModel.videoUrl!)
                    : locator<MyWidgets>().cacheImage(widget.articalModel.thumnail!),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (_) => MyCommentScreen(),
                        //     settings: RouteSettings(arguments: CommentArgs(widget.articalModel.id)),
                        //   ),
                        // );
                      },
                      child: Text(
                        widget.articalModel.title!,
                        style: style.subtitleBText(context)!.copyWith(height: 1.3),
                        textAlign: TextAlign.justify,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  fcHSizedBox1,
                  IconButton(
                    onPressed: () {
                      Share.share('check out my website https://example.com', subject: 'Look what I made!');
                    },
                    icon: Icon(MyIcons.share, size: 22),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: InkWell(
                onTap: () => setState(() => lines = !lines),
                onDoubleTap: () {
                  speak = !speak;
                  if (speak) {
                    _flutterTts.stop();
                  } else {
                    _flutterTts.speak(widget.articalModel.description!);
                  }
                },
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Text(
                    widget.articalModel.description!,
                    style: style.bodyText(context),
                    textAlign: TextAlign.justify,
                    maxLines: lines ? 12 : 50,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            fcVSizedBox1,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        widget.articalModel.categoryName!,
                        style: style.bodyBText(context)!.copyWith(color: MyColors.white),
                      ),
                      fcVSizedBox,
                      Text(locator<MyDateTime>().formateDate(widget.articalModel.updateAt), style: style.xSmallBText(context)),
                      SizedBox(height: lines ? 0 : 50)
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      locator<NavigationService>().navigateTo(MyWebViewPage(url: widget.articalModel.sourceUrl!));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Icon(MyIcons.information),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
