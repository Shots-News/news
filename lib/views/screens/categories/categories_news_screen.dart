import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/bloc/articles/articles_bloc.dart';
import 'package:news/models/article_model.dart';
import 'package:news/views/screens/messages/comment_screen.dart';
import 'package:news/views/widgets/news_card_widget.dart';

class MyCategoryNewsScreen extends StatelessWidget {
  const MyCategoryNewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: BlocBuilder<ArticlesBloc, ArticlesState>(
            builder: (BuildContext context, ArticlesState state) {
              if (state is ArticlesError) {
                final error = state.error;
                String message = '${error.message}\nTap to Retry.';
                return Text(message);
              } else if (state is ArticlesLoaded) {
                List<ArticleModel> articals = state.articles;
                return _pageViewBuilder(articals);
              } else if (state is ArticlesLoading) {
                List<ArticleModel> articals = state.articles!;
                return _pageViewBuilder(articals);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

  /// For Bloc
  _pageViewBuilder(List<ArticleModel> articals) {
    return PageView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: articals.length,
      scrollDirection: Axis.vertical,
      scrollBehavior: ScrollBehavior(),
      controller: PageController(keepPage: false),
      itemBuilder: (BuildContext context, int index) {
        PageController controller = PageController();
        print(articals[index].id);
        return PageView(
          scrollDirection: Axis.horizontal,
          controller: controller,
          children: [
            /// [Feed]
            NewsCardWidget(articalModel: articals[index]),

            /// [Message]
            MyCommentScreen(
              articalModel: articals[index],
              controller: controller,
              newsId: articals[index].id!,
            ),
          ],
        );
      },
    );
  }
}
