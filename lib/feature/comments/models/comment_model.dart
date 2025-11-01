class Comment {
  final String name;
  final String time;
  final String text;
  int likes;
  bool isLiked;

  Comment({
    required this.name,
    required this.time,
    required this.text,
    this.likes = 20,
    this.isLiked = false,
  });
}
