import 'likes.dart';

class Post {
  String userid;
  String title;
  String description;
  String image;
  String id;
  String author;
  String likes;
  String dislikes;
  List<Like> Likes;
  String commentsAmount;
  String time;

  Post.fromJson(Map<String, dynamic> map)
      : userid = map['_id'],
        title = map['Title'],
        description = map['Description'],
        author = map['Author'],
        image = map['image'];

  Post(
      this.id,
      this.title,
      this.userid,
      this.Likes,
      this.author,
      this.commentsAmount,
      this.description,
      this.dislikes,
      this.image,
      this.likes,
      this.time);
}
