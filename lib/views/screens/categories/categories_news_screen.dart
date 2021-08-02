import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/bloc/articals/articals_bloc.dart';
import 'package:news/models/artical_model.dart';
import 'package:news/views/screens/messages/comment_screen.dart';
import 'package:news/views/widgets/news_card_widget.dart';

class MyCategoryNewsScreen extends StatelessWidget {
  const MyCategoryNewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
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
      ),
    );
  }

  /// For Bloc
  _pageViewBuilder(List<ArticalModel> articals) {
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