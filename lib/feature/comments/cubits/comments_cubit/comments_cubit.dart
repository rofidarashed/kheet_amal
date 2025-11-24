import 'dart:developer' as developer;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kheet_amal/feature/comments/cubits/comments_cubit/comments_state.dart';
import 'package:kheet_amal/feature/comments/data/repo/comments_repo.dart';
import 'package:kheet_amal/feature/comments/data/models/comment_model.dart';

class CommentsCubit extends Cubit<CommentsState> {
  CommentsCubit() : super(CommentsStateInitial());
  CommentsRepo repo = CommentsRepoImpl();
  final user = FirebaseAuth.instance.currentUser!;

  final List<Comment> _commentsCache = [];
  List<Comment> get comments => List.unmodifiable(_commentsCache);

  Future<String> getUserName() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();
    return doc.data()!['name'];
  }

  Future<void> addComments({
    required String postId,
    required String text,
    String? userid,
  }) async {
    if (_commentsCache.isEmpty) emit(CommentsStateLoading());
    try {
      final String userName = await getUserName();
      await repo.addComments(
        postId: postId,
        text: text,
        userId: user.uid,
        userName: userName,
      );

      await getComments(postId: postId);
      emit(CommentsStateSuccess());
    } catch (e) {
      emit(CommentsStateError(e.toString()));
    }
  }

  Future<void> getComments({required String postId}) async {
    if (_commentsCache.isEmpty) emit(CommentsGetLoading());

    try {
      final comments = await repo.getComments(postId: postId);

      for (var c in comments) {
        c.replies = await repo.getReplies(postId: postId, commentId: c.id);
      }

      _commentsCache
        ..clear()
        ..addAll(comments);

      emit(CommentsGetSuccess(List.unmodifiable(_commentsCache)));
    } catch (e) {
      emit(CommentsGetError(e.toString()));
    }
  }

  Future<void> replyToComment({
    required String postId,
    required String commentId,
    required String text,
    String? userid,
  }) async {
    emit(ReplyStateLoading());
    try {
      final String userName = await getUserName();

      final optimisticReply = Comment(
        id: DateTime.now().toIso8601String(),
        name: userName,
        time: 'منذ لحظات',
        text: text,
        likes: 0,
        isLiked: false,
        replies: [],
        likedBy: [],
      );

      final idx = _commentsCache.indexWhere((c) => c.id == commentId);
      if (idx != -1) {
        final target = _commentsCache[idx];
        target.replies = [optimisticReply, ...target.replies];
        emit(CommentsGetSuccess(List.unmodifiable(_commentsCache)));
      }
      await repo.replyToComment(
        postId: postId,
        commentId: commentId,
        text: text,
        userId: user.uid,
        userName: userName,
      );

      await getReplies(postId: postId, commentId: commentId);

      emit(ReplyStateSuccess());
    } catch (e) {
      emit(ReplyStateError(e.toString()));
    }
  }

  Future<void> getReplies({
    required String postId,
    required String commentId,
  }) async {
    try {
      final replies = await repo.getReplies(
        postId: postId,
        commentId: commentId,
      );

      final idx = _commentsCache.indexWhere((c) => c.id == commentId);
      if (idx != -1) {
        _commentsCache[idx].replies = replies;
        emit(CommentsGetSuccess(List.unmodifiable(_commentsCache)));
        return;
      }

      await getComments(postId: postId);
    } catch (e) {
      emit(RepliesGetError(commentId));
    }
  }

  Future<void> reportComment({
    required String postId,
    required String commentId,
    required String reason,
    required String details,
  }) async {
    emit(ReportCommentLoading());
    try {
      await repo.reportComment(
        postId: postId,
        commentId: commentId,
        reason: reason,
        details: details,
        reporterId: user.uid,
      );
      emit(ReportCommentSuccess());
    } catch (e) {
      emit(ReportCommentError(e.toString()));
    }
  }

  Future<void> toggleLike({
    required String postId,
    required String commentId,
  }) async {
    final uid = user.uid;

    final idx = _commentsCache.indexWhere((c) => c.id == commentId);
    if (idx == -1) return;

    final target = _commentsCache[idx];

    final previousIsLiked = target.isLiked;
    final previousLikes = target.likes;

    try {
      if (target.isLiked) {
        target.isLiked = false;
        target.likes--;
        target.likedBy.remove(uid);
        emit(CommentsGetSuccess(List.unmodifiable(_commentsCache)));

        await repo.unlikeComment(
          postId: postId,
          commentId: commentId,
          userId: uid,
        );
      } else {
        target.isLiked = true;
        target.likes++;
        if (!target.likedBy.contains(uid)) {
          target.likedBy.add(uid);
        }
        emit(CommentsGetSuccess(List.unmodifiable(_commentsCache)));

        await repo.likeComment(
          postId: postId,
          commentId: commentId,
          userId: uid,
        );
      }
    } catch (e) {
      developer.log('Error toggling like: $e', name: 'CommentsCubit');
      target.isLiked = previousIsLiked;
      target.likes = previousLikes;
      if (previousIsLiked) {
        if (!target.likedBy.contains(uid)) {
          target.likedBy.add(uid);
        }
      } else {
        target.likedBy.remove(uid);
      }
      emit(CommentsGetSuccess(List.unmodifiable(_commentsCache)));
    }
  }

  Future<void> toggleReplyLike({
    required String postId,
    required String commentId,
    required String replyId,
  }) async {
    final uid = user.uid;

    final commentIdx = _commentsCache.indexWhere((c) => c.id == commentId);
    if (commentIdx == -1) return;

    // Find the reply
    final replyIdx = _commentsCache[commentIdx].replies.indexWhere(
      (r) => r.id == replyId,
    );
    if (replyIdx == -1) return;

    final target = _commentsCache[commentIdx].replies[replyIdx];
    final previousIsLiked = target.isLiked;
    final previousLikes = target.likes;

    try {
      if (target.isLiked) {
        target.isLiked = false;
        target.likes--;
        target.likedBy.remove(uid);
        emit(CommentsGetSuccess(List.unmodifiable(_commentsCache)));

        await repo.unlikeReply(
          postId: postId,
          commentId: commentId,
          replyId: replyId,
          userId: uid,
        );
      } else {
        target.isLiked = true;
        target.likes++;
        if (!target.likedBy.contains(uid)) {
          target.likedBy.add(uid);
        }
        emit(CommentsGetSuccess(List.unmodifiable(_commentsCache)));

        await repo.likeReply(
          postId: postId,
          commentId: commentId,
          replyId: replyId,
          userId: uid,
        );
      }
    } catch (e) {
      developer.log('Error toggling reply like: $e', name: 'CommentsCubit');
      target.isLiked = previousIsLiked;
      target.likes = previousLikes;
      if (previousIsLiked) {
        if (!target.likedBy.contains(uid)) {
          target.likedBy.add(uid);
        }
      } else {
        target.likedBy.remove(uid);
      }
      emit(CommentsGetSuccess(List.unmodifiable(_commentsCache)));
    }
  }

  Future<void> commentCount({required String postId}) async {
    if (postId.isEmpty) {
      return;
    }
    final count = await repo.getCountComment(postId: postId);
    if (!isClosed) {
      emit(CommentCountState(count: count));
    }
  }
}
