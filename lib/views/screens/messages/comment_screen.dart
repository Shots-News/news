import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_const/flutter_const.dart';
import 'package:news/bloc/comments/comments_bloc.dart';
import 'package:news/constant/app_icons.dart';
import 'package:news/constant/colors.dart';
import 'package:news/constant/constant.dart';
import 'package:news/constant/dimensions.dart';
import 'package:news/locator.dart';
import 'package:news/models/artical_model.dart';
import 'package:news/services/firebase_service.dart';
import 'package:news/views/widgets/message_widget.dart';
import 'package:provider/provider.dart';

class MyCommentScreen extends StatefulWidget {
  final ArticalModel articalModel;
  final PageController controller;
  final int newsId;

  MyCommentScreen({Key? key, required this.articalModel, required this.controller, required this.newsId}) : super(key: key);

  @override
  _MyCommentScreenState createState() => _MyCommentScreenState();
}

class _MyCommentScreenState extends State<MyCommentScreen> {
  final TextEditingController _controller = TextEditingController();
  CommentsBloc _commentsBloc = CommentsBloc(7);

  @override
  void initState() {
    _commentsBloc.add(CommentsEventStart());
    super.initState();
  }

  bool onWillPop() {
    widget.controller.previousPage(
      duration: Duration(milliseconds: 200),
      curve: Curves.linear,
    );
    return false;
  }

  @override
  void dispose() {
    _commentsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);
    final double bottomSize = 60;
    return SafeArea(
      child: WillPopScope(
        onWillPop: () => Future.sync(onWillPop),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Comments',
              style: style.h6BText(context),
            ),
          ),
          body: Container(
            width: MyDimensions.width(context),
            height: MyDimensions.height(context),
            child: Column(
              children: [
                BlocBuilder<CommentsBloc, CommentsState>(
                  bloc: _commentsBloc,
                  builder: (BuildContext context, CommentsState state) {
                    print(state);
                    if (state is CommentsStateLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is CommentsStateLoadSuccess) {
                      print(state.comments);
                      return MessagesList(
                        messages: state.comments,
                        userId: _user != null ? _user.uid : '0',
                      );
                    } else if (state is CommentsStateEmpty) {
                      return Center(
                        child: Text(
                          'No Posts',
                          style: style.h6BText(context),
                        ),
                      );
                    } else if (state is CommentsInitialState) {
                      return Center(
                        child: Image.asset('assets/gif/pikachu.gif'),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                _user == null
                    ? Container()
                    : Container(
                        height: bottomSize,
                        color: MyColors.lightBlack,
                        child: Row(
                          children: [
                            fcHSizedBox1,
                            Expanded(
                              child: TextField(
                                controller: _controller,
                                cursorColor: Colors.grey,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter Comment',
                                ),
                              ),
                            ),
                            fcHSizedBox1,
                            IconButton(
                              onPressed: () {
                                var comment = _controller.text.trim().toString();

                                if (comment.isNotEmpty) {
                                  locator<FirebaseService>()
                                      .sendComment(
                                        messageBody: comment,
                                        newsId: widget.articalModel.id!,
                                        senderId: _user.uid,
                                        senderName: _user.displayName!,
                                        newsName: widget.articalModel.title!,
                                      )
                                      .whenComplete(() => _controller.clear());
                                }
                              },
                              icon: Icon(MyIcons.play_button),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
