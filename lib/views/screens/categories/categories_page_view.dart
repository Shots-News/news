import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:news/constant/dimensions.dart';
import 'package:news/repository/artical_repo.dart';
import 'package:news/views/widgets/bottom_bar.dart';
import 'package:news/views/widgets/news_card_widget.dart';
import 'package:news/views/widgets/widgets.dart';
import 'package:provider/provider.dart';

class MyCategoryPageView extends StatefulWidget {
  const MyCategoryPageView({Key? key}) : super(key: key);

  @override
  _MyCategoryPageViewState createState() => _MyCategoryPageViewState();
}

class _MyCategoryPageViewState extends State<MyCategoryPageView> {
  final _flutterTts = FlutterTts();
  int maxLine = 10;

  PageController? _pageController;

  @override
  void initState() {
    _flutterTts.setLanguage('en');
    _flutterTts.setSpeechRate(0.4);
    _flutterTts.setVolume(1);

    final articals = Provider.of<ArticalService>(context, listen: false);
    articals.getArticalsList();
    super.initState();
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final articals = Provider.of<ArticalService>(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MyDimensions.height(context),
          child: PageView.builder(
            physics: BouncingScrollPhysics(),
            controller: _pageController,
            itemCount: articals.data.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              print(articals.data.length);
              return articals.data.length == 0
                  ? Center(child: CircularProgressIndicator())
                  : Stack(
                      children: [
                        NewsCardWidget(
                          desc: articals.data[index].description!,
                          title: articals.data[index].title!,
                          source: articals.data[index].sourceUrl!,
                          image: articals.data[index].thumnail,
                          isVideo: articals.data[index].isVideo!,
                          video: articals.data[index].videoUrl!,
                        ),
                        Column(
                          children: [
                            MyExpandedWidget(),
                            BottomBarWidget(
                              flutterTts: _flutterTts,
                              description: articals.data[index].description!,
                            ),
                          ],
                        ),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}
