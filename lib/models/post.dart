class Post {
  String userid;
  String title;
  String description;
  String image;

  String author;
  String likes;
  String dislikes;
  String commentsAmount;
  String time;

  Post.fromJson(Map<String, dynamic> map)
      : userid = map['_id'],
        title = map['Title'],
        description = map['Description'],
        author = map['Author'],
        image = map['image'];
}
