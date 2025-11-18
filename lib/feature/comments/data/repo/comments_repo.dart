import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kheet_amal/feature/comments/data/models/comment_model.dart';

abstract class CommentsRepo {
  Future<void> addComments({
    required String postId,
    required String text,
    required String userId,
    required String userName,
  });
  Future<List<Comment>> getComments({required String postId});
  Future<void> replyToComment({
    required String postId,
    required String commentId,
    required String text,
    required String userId,
    required String userName,
  });
  Future<List<Comment>> getReplies({
    required String postId,
    required String commentId,
  });
  Future<void> reportComment({
    required String postId,
    required String commentId,
    required String reason,
    required String details,
    required String reporterId,
  });
  Future<void> likeComment({
    required String postId,
    required String commentId,
    required String userId,
  });

  Future<void> unlikeComment({
    required String postId,
    required String commentId,
    required String userId,
  });

  Future<void> likeReply({
    required String postId,
    required String commentId,
    required String replyId,
    required String userId,
  });

  Future<void> unlikeReply({
    required String postId,
    required String commentId,
    required String replyId,
    required String userId,
  });
  Future<int> getCountComment({required String postId});
}

class CommentsRepoImpl extends CommentsRepo {
  @override
  Future<void> addComments({
    required String postId,
    required String text,
    required String userId,
    required String userName,
  }) async {
    final commentsRef = FirebaseFirestore.instance
        .collection('reports')
        .doc(postId)
        .collection('comments')
        .doc();

    await commentsRef.set({
      'id': commentsRef.id,
      'postId': postId,
      'text': text,
      'userId': userId,
      'userName': userName,
      'name': userName,
      'likes': 0,
      'likedBy': [],
      'createdAt': Timestamp.now(),
    });
  }

  @override
  Future<List<Comment>> getComments({required String postId}) async {
    final snapShot = await FirebaseFirestore.instance
        .collection('reports')
        .doc(postId)
        .collection('comments')
        .orderBy('createdAt', descending: true)
        .get();

    final comments = snapShot.docs.map((doc) {
      final data = doc.data();
      final createdAt = (data['createdAt'] as Timestamp).toDate();
      data['time'] = _getTimeAgo(createdAt);

      return Comment.fromJson(data);
    }).toList();
    return comments;
  }

  @override
  Future<void> replyToComment({
    required String postId,
    required String commentId,
    required String text,
    required String userId,
    required String userName,
  }) async {
    final replyRef = FirebaseFirestore.instance
        .collection('reports')
        .doc(postId)
        .collection('comments')
        .doc(commentId)
        .collection('replies')
        .doc();

    await replyRef.set({
      'id': replyRef.id,
      'postId': postId,
      'commentId': commentId,
      'text': text,
      'userId': userId,
      'name': userName,
      'likes': 0,
      'likedBy': [],
      'createdAt': Timestamp.now(),
    });
  }

  @override
  Future<List<Comment>> getReplies({
    required String postId,
    required String commentId,
  }) async {
    final snapShot = await FirebaseFirestore.instance
        .collection('reports')
        .doc(postId)
        .collection('comments')
        .doc(commentId)
        .collection('replies')
        .orderBy('createdAt', descending: true)
        .get();

    final replaycomments = snapShot.docs.map((doc) {
      final data = doc.data();
      final createdAt = (data['createdAt'] as Timestamp).toDate();
      data['time'] = _getTimeAgo(createdAt);

      return Comment.fromJson(data);
    }).toList();
    return replaycomments;
  }

  @override
  Future<void> reportComment({
    required String postId,
    required String commentId,
    required String reason,
    required String details,
    required String reporterId,
  }) async {
    final reportRef = FirebaseFirestore.instance
        .collection('reports')
        .doc(postId)
        .collection('comments')
        .doc(commentId)
        .collection('comment_reports')
        .doc();

    await reportRef.set({
      'id': reportRef.id,
      'postId': postId,
      'commentId': commentId,
      'reason': reason,
      'details': details,
      'reporterId': reporterId,
      'createdAt': Timestamp.now(),
    });
  }

  @override
  Future<void> likeComment({
    required String postId,
    required String commentId,
    required String userId,
  }) async {
    final commentRef = FirebaseFirestore.instance
        .collection('reports')
        .doc(postId)
        .collection('comments')
        .doc(commentId);

    await commentRef.update({
      'likes': FieldValue.increment(1),
      'likedBy': FieldValue.arrayUnion([userId]),
    });
  }

  @override
  Future<void> unlikeComment({
    required String postId,
    required String commentId,
    required String userId,
  }) async {
    final commentRef = FirebaseFirestore.instance
        .collection('reports')
        .doc(postId)
        .collection('comments')
        .doc(commentId);

    await commentRef.update({
      'likes': FieldValue.increment(-1),
      'likedBy': FieldValue.arrayRemove([userId]),
    });
  }

  @override
  Future<void> likeReply({
    required String postId,
    required String commentId,
    required String replyId,
    required String userId,
  }) async {
    final replyRef = FirebaseFirestore.instance
        .collection('reports')
        .doc(postId)
        .collection('comments')
        .doc(commentId)
        .collection('replies')
        .doc(replyId);

    await replyRef.update({
      'likes': FieldValue.increment(1),
      'likedBy': FieldValue.arrayUnion([userId]),
    });
  }

  @override
  Future<void> unlikeReply({
    required String postId,
    required String commentId,
    required String replyId,
    required String userId,
  }) async {
    final replyRef = FirebaseFirestore.instance
        .collection('reports')
        .doc(postId)
        .collection('comments')
        .doc(commentId)
        .collection('replies')
        .doc(replyId);

    await replyRef.update({
      'likes': FieldValue.increment(-1),
      'likedBy': FieldValue.arrayRemove([userId]),
    });
  }

  @override
  Future<int> getCountComment({required String postId}) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('reports')
        .doc(postId)
        .collection('comments')
        .get();

    return snapshot.docs.length;
  }
}

String _getTimeAgo(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inSeconds < 60) {
    return 'منذ ${difference.inSeconds} ثانية';
  } else if (difference.inMinutes < 60) {
    return 'منذ ${difference.inMinutes} دقيقة';
  } else if (difference.inHours < 24) {
    return 'منذ ${difference.inHours} ساعة';
  } else {
    return 'منذ ${difference.inDays} يوم';
  }
}
