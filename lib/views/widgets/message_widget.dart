import 'package:flutter/cupertino.dart';
import 'package:news/models/comment_model.dart';
import 'package:news/views/widgets/bubble_widget.dart';

class MessagesList extends StatelessWidget {
  const MessagesList({
    Key? key,
    required this.messages,
    this.userId,
  }) : super(key: key);

  final List<CommentModel> messages;
  final String? userId;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 20),
        reverse: true,
        itemCount: messages.length,
        itemBuilder: (ctx, idx) {
          bool isSent = messages[idx].userId == userId;
          return ChatBubble(
            isSent: isSent,
            message: messages[idx].messageBody!,
            name: messages[idx].userName!,
          );
        },
      ),
    );
  }
}
