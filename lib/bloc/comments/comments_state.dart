part of 'comments_bloc.dart';

abstract class CommentsState extends Equatable {
  const CommentsState();

  @override
  List<Object> get props => [];
}

class CommentsInitialState extends CommentsState {}

class CommentsStateLoading extends CommentsState {}

class CommentsStateEmpty extends CommentsState {}

class CommentsStateLoadSuccess extends CommentsState {
  final List<CommentModel> comments;
  final bool hasMoreData;

  const CommentsStateLoadSuccess(this.comments, this.hasMoreData);

  @override
  List<Object> get props => [comments];
}
