class Comment {
  final String id;
  final String message;

  Comment({this.id, this.message});

  factory Comment.fromJson(Map<String, dynamic> json){
    return Comment(
        id: json['id'],
        message: json['message']
    );
  }

}