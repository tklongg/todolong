class Comment {
  final int id;
  final String text;
  final String attachments;

  Comment({
    required this.id,
    required this.text,
    this.attachments = '',
  });

  Comment.toJson(Map<String, dynamic> json)
      : id = json['id'],
        text = json['text'],
        attachments = json['attachments'];
}
