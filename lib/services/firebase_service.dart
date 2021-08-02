import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:news/models/comment_model.dart';

class FirebaseService {
  final CollectionReference _ref = FirebaseFirestore.instance.collection('comments');

  Future createComment(CommentModel commentModel) async {
    try {
      await _ref.doc().set(commentModel.toJson());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future sendComment({
    required String messageBody,
    required int newsId,
    required String senderId,
    required String senderName,
    required String newsName,
  }) async {
    final CommentModel _comment = CommentModel(
      messageBody: messageBody,
      newsId: newsId,
      newsName: newsName,
      userId: senderId,
      userName: senderName,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    await createComment(_comment);
  }
}
