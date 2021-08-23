import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/bloc/articles/articles_bloc.dart';
import 'package:news/models/article_model.dart';
import 'package:news/models/category_model.dart';
import 'package:news/views/screens/messages/comment_screen.dart';
import 'package:news/views/widgets/news_card_widget.dart';

class MyCategoryNewsScreen extends StatelessWidget {
  const MyCategoryNewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryModel = ModalRoute.of(context)!.settings.arguments as CategoryModel;
    print("commentModel: ${categoryModel.id}");
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
                return _pageViewBuilder(articals, categoryModel.id);
              } else if (state is ArticlesLoading) {
                List<ArticleModel> articals = state.articles!;
                return _pageViewBuilder(articals, categoryModel.id);
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
  _pageViewBuilder(List<ArticleModel> articals, int? categoriesID) {
    List<ArticleModel>? _temp;

    for (int i = 0; i < articals.length; i++) {
      if (articals[i].categoryId == categoriesID) {
        _temp!.addAll(articals);
      }
    }
    return PageView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: _temp!.length,
      scrollDirection: Axis.vertical,
      scrollBehavior: ScrollBehavior(),
      controller: PageController(keepPage: false),
      itemBuilder: (BuildContext context, int index) {
        PageController controller = PageController();
        return PageView(
          scrollDirection: Axis.horizontal,
          controller: controller,
          children: [
            /// [Feed]
            NewsCardWidget(articalModel: _temp[index]),

            /// [Message]
            MyCommentScreen(
              articalModel: _temp[index],
              controller: controller,
              newsId: _temp[index].id!,
            ),
          ],
        );
      },
    );
  }
}
