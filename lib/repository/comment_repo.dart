import 'package:cloud_firestore/cloud_firestore.dart';

class CommentRepository {
  // Singleton boilerplate
  CommentRepository._();

  // Instance
  final CollectionReference _ref = FirebaseFirestore.instance.collection('comments');

  static CommentRepository _instance = CommentRepository._();
  static CommentRepository get instance => _instance;

  Stream<QuerySnapshot> getPosts(int newsID) {
    //.where('newsId', isEqualTo: newsID)
    return _ref.orderBy('createdAt', descending: true).limit(15).snapshots();
  }

  Stream<QuerySnapshot> getPostsPage(DocumentSnapshot lastDoc) {
    return _ref.orderBy('createdAt', descending: true).startAfterDocument(lastDoc).limit(15).snapshots();
  }
}
