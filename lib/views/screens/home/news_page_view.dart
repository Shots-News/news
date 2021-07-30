import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/bloc/articals/articals_bloc.dart';
import 'package:news/constant/app_icons.dart';
import 'package:news/constant/colors.dart';
import 'package:news/constant/constant.dart';
import 'package:news/constant/dimensions.dart';
import 'package:news/locator.dart';
import 'package:news/models/artical_model.dart';
import 'package:news/routes/navigation_service.dart';
import 'package:news/views/screens/home/home_screen.dart';
import 'package:news/views/screens/home/web_view.dart';
import 'package:news/views/screens/library/library_screen.dart';
import 'package:news/views/screens/messages/comment_screen.dart';
import 'package:news/views/widgets/news_card_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class MyNewsPageView extends StatefulWidget {
  const MyNewsPageView({Key? key}) : super(key: key);

  @override
  _MyNewsPageViewState createState() => _MyNewsPageViewState();
}

class _MyNewsPageViewState extends State<MyNewsPageView> {
  @override
  void initState() {
    super.initState();

    // blocs
    loadArticals();
  }

  loadArticals() {
    context.read<ArticalsBloc>().add(ArticalsEvent.fetchArticals);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Container(
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
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  /// For Bloc
  _pageViewBuilder(List<ArticalModel> articals) {
    return PageView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: articals.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return TabBarView(
          children: [
            /// [Library]
            MyLibraryScreen(),

            /// [Feed]
            Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      color: MyColors.lightBlack,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () => locator<NavigationService>().navigateTo(
                              MyLibraryScreen(),
                              childCurrent: MyHomeScreen(),
                              transition: PageTransitionType.leftToRight,
                            ),
                            icon: Icon(MyIcons.cursor, color: MyColors.white),
                          ),
                          Text('News', style: style.h5BText(context)),
                          IconButton(
                            onPressed: () => locator<NavigationService>().navigateTo(
                              MyCommentScreen(),
                              childCurrent: MyHomeScreen(),
                              transition: PageTransitionType.rightToLeftJoined,
                            ),
                            icon: Icon(MyIcons.chat, color: MyColors.white),
                          ),
                        ],
                      ),
                    ),
                    NewsCardWidget(
                      desc: articals[index].description!,
                      title: articals[index].title!,
                      source: articals[index].sourceUrl!,
                      image: articals[index].thumnail,
                      isVideo: articals[index].isVideo!,
                      video: articals[index].videoUrl!,
                      updateAt: articals[index].updateAt,
                    ),
                  ],
                ),
              ),
            ),

            /// [Message]
            MyCommentScreen()
          ],
        );
      },
    );
  }
}
