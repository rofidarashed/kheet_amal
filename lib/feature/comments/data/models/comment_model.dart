  import 'package:firebase_auth/firebase_auth.dart';

  class Comment {
    final String id;
    final String name;
    final String time;
    final String text;
    int likes;
    bool isLiked;
    List<String> likedBy;

    List<Comment> replies;

    Comment({
      required this.id,
      required this.name,
      required this.time,
      required this.text,
      this.likes = 0,
      this.isLiked = false,
      this.replies = const [],
      this.likedBy = const [],

    });

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
      id: json['id'] ?? '',
      name: json['name'] ?? json['userName'] ?? 'Unknown User',
      time: json['time'] ?? 'منذ لحظات',
      text: json['text'] ?? '',
      likes: (json['likes'] ?? 0),
      likedBy: List<String>.from(json['likedBy'] ?? []),

      isLiked: (json['likedBy'] ?? []).contains(FirebaseAuth.instance.currentUser!.uid),
      replies: (json['replies'] as List<dynamic>?)
          ?.map((r) => Comment.fromJson(r as Map<String, dynamic>))
          .toList() ??
          [],
    );

    Map<String, dynamic> toJson() => {
      'id': id,
      'name': name,
      'time': time,
      'text': text,
      'likes': likes,
      'isLiked': isLiked,
    };
  }
