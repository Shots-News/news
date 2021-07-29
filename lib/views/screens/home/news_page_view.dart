import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:news/bloc/articals/articals_bloc.dart';
import 'package:news/constant/dimensions.dart';
import 'package:news/models/artical_model.dart';
import 'package:news/views/widgets/bottom_bar.dart';
import 'package:news/views/widgets/news_card_widget.dart';
import 'package:news/views/widgets/widgets.dart';
import 'package:provider/provider.dart';

class MyNewsPageView extends StatefulWidget {
  const MyNewsPageView({Key? key}) : super(key: key);

  @override
  _MyNewsPageViewState createState() => _MyNewsPageViewState();
}

class _MyNewsPageViewState extends State<MyNewsPageView> {
  final _flutterTts = FlutterTts();
  int maxLine = 10;

  PageController? _pageController;

  @override
  void initState() {
    _flutterTts.setLanguage('en');
    _flutterTts.setSpeechRate(0.4);
    _flutterTts.setVolume(1);
    super.initState();

    // blocs
    loadArticals();
  }

  loadArticals() {
    context.read<ArticalsBloc>().add(ArticalsEvent.fetchArticals);
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MyDimensions.height(context),
      child: BlocBuilder<ArticalsBloc, ArticalsState>(
        builder: (BuildContext context, ArticalsState state) {
          if (state is ArticalsError) {
            final error = state.error;
            String message = '${error.message}\nTap to Retry.';
            return Text(message);
          } else if (state is ArticalsLoaded) {
            List<ArticalModel> articals = state.artical;
            return _pageViewBuilder(articals);
          } else if (state is ArticalsLoading) {
            List<ArticalModel> articals = state.artical!;
            return _pageViewBuilder(articals);
          } else {
            print(state);
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  /// For Bloc
  _pageViewBuilder(List<ArticalModel> articals) {
    return PageView.builder(
      physics: BouncingScrollPhysics(),
      controller: _pageController,
      itemCount: articals.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return Stack(
          children: [
            NewsCardWidget(
              desc: articals[index].description!,
              title: articals[index].title!,
              source: articals[index].sourceUrl!,
              image: articals[index].thumnail,
              isVideo: articals[index].isVideo!,
              video: articals[index].videoUrl!,
            ),
            Column(
              children: [
                MyExpandedWidget(),
                BottomBarWidget(
                  flutterTts: _flutterTts,
                  description: articals[index].description!,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
