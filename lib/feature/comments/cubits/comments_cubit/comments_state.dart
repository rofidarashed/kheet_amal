import 'package:kheet_amal/feature/comments/data/models/comment_model.dart';

abstract class CommentsState {}

class CommentsStateInitial extends CommentsState {}

class CommentsStateLoading extends CommentsState {}

class CommentsStateSuccess extends CommentsState {}

class CommentsStateError extends CommentsState {
  final String message;

  CommentsStateError(this.message);
}
class CommentsGetLoading extends CommentsState {}

class CommentsGetSuccess extends CommentsState {
  final List<Comment> comments;

  CommentsGetSuccess(this.comments);
}

class CommentsGetError extends CommentsState {
  final String message;

  CommentsGetError(this.message);
}
class ReplyStateLoading extends CommentsState {}

class ReplyStateSuccess extends CommentsState {}

class ReplyStateError extends CommentsState {
  final String message;

  ReplyStateError(this.message);
}
class RepliesGetLoading extends CommentsState {}

class RepliesGetSuccess extends CommentsState {
  final List<Comment> replies;

  RepliesGetSuccess(this.replies);
}

class RepliesGetError extends CommentsState {
  final String message;

  RepliesGetError(this.message);
}
class ReportCommentLoading extends CommentsState {}

class ReportCommentSuccess extends CommentsState {}

class ReportCommentError extends CommentsState {
  final String message;
  ReportCommentError(this.message);
}
class CommentCountState extends CommentsState {
  final int count;

  CommentCountState({required this.count});
}