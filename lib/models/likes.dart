class Like {
  String userid;
  String post_id;
  bool isliked;
  String type;

  Like.fromJson(Map<String, dynamic> map)
      : userid = map['userid'],
        post_id = map['Post_id'],
        isliked = map['isliked'],
        type = map['type'];
}
