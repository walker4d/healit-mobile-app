import 'package:click_counter/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:localstorage/localstorage.dart';
import '../models/post.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../models/likes.dart';

final LocalStorage storage = new LocalStorage('User');

// User user = User.fromJson(storage.getItem("User"));
// print(user);

Map<String, dynamic> map = storage.getItem('User');
// print('after jsondecode');

User user = User.fromJson(map);
Widget Postcard() {
  return Card(
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: [
        ListTile(
          leading: Icon(Icons.arrow_drop_down_circle),
          title: const Text('benefits of herb'),
          subtitle: Text(
            'Annette Walker',
            style: TextStyle(color: Colors.black.withOpacity(0.6)),
          ),
        ),
        Image.network(
            'https://res.cloudinary.com/healit/image/upload/v1606429158/images/rdr4ibhtupp00bp4igvo.jpg'),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'these herbs are certainly good but what makes them good is the fact that they provide nutrients to us in away that imporves ones health.',
            style: TextStyle(color: Colors.black.withOpacity(0.6)),
          ),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.start,
          children: [
            FlatButton(
              onPressed: () {
                // Perform some action
              },
              child: const Text('dislike '),
            ),
            FlatButton(
              onPressed: () {
                // Perform some action
              },
              child: const Text('like 2'),
            ),
          ],
        ),
      ],
    ),
  );
}

String calculateLikes(String type, List<Like> likes) {
  List<Like> l = likes.where((i) => i.type == type).toList();

  return l.length.toString();
}

String calculateComents(comments) {
  if (comments == null) {
    return 0.toString();
  }

  return comments.toString();
}

Future<http.Response> likePost(Post post, String type) async {
  if (storage.getItem('User') != null) {
    List<Like> l = post.Likes.where((i) => i.userid == user.id).toList();
    bool isliked;
    if (l.length < 1) {
      isliked = true;
    } else if (l[0].type == type) {
      isliked = false;
    }

    var url = 'http://10.0.2.2:8000/posts/like/${post.id}';
    print('userid ' + user.id);
    final http.Response response = await http.put(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'userid': user.id,
          'Post_id': post.id,
          'isliked': isliked.toString(),
          'type': type
        }));
    if (response.statusCode == 200) {
      return response;
    } else {
      print(response.body);
      print('failed to like');
      return null;
    }
  }
  return null;
}

postcard() {
  return Container(
      constraints: BoxConstraints(
        minHeight: 50.0,
        maxHeight: 460.0,
      ),
      child: FutureBuilder(
          future: getPosts(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(snapshot.data);
            if (snapshot.connectionState != ConnectionState.done) {
              // return: show loading widget
              print('loading ');
            }
            if (snapshot.hasError) {
              // return: show error widget
              print('error');
            }
            List<Post> posts = snapshot.data;

            return ListView.builder(
                // scrollDirection: Axis.vertical,
                itemCount: posts.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.arrow_drop_down_circle),
                          title: Text(posts[index].author),
                          subtitle: Text(
                            posts[index].title,
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                        ),
                        Image.network(posts[index].image),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            posts[index].description,
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.start,
                          children: [
                            FlatButton(
                              onPressed: () async {
                                // Perform some action
                                http.Response response =
                                    await likePost(posts[index], 'dislike');

                                if (response != null) {
                                  print(response);
                                } else {
                                  print('null');
                                }
                              },
                              child: Text('dislike ' +
                                  calculateLikes(
                                      'dislike', posts[index].Likes)),
                            ),
                            FlatButton(
                              onPressed: () async {
                                // Perform some action
                                http.Response response =
                                    await likePost(posts[index], 'like');
                                if (response != null) {
                                  print(response);
                                } else {
                                  print('null');
                                }
                              },
                              child: Text('like ' +
                                  calculateLikes('like', posts[index].Likes)),
                            ),
                            FlatButton(
                              onPressed: () {
                                // Perform some action
                              },
                              child: Text(calculateComents(
                                      posts[index].commentsAmount) +
                                  ' comments'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                });
          }));
}

Future<List<Post>> getPosts() async {
  var data = await http.get("http://10.0.2.2:8000/posts/");

  var jsonData = json.decode(data.body);

  List<Post> posts = [];

  for (var post in jsonData) {
    Map<String, dynamic> map = post;
    List<Like> Likes = [];
    for (var like in map['Likes']) {
      Likes.add(Like.fromJson(like));
    }
    print(map['comments_amount']);

    posts.add(new Post(
        map['_id'],
        map['Title'],
        map['userid'],
        Likes,
        map['Author'],
        map['comments_amount'],
        map['Description'],
        '0',
        map['image'],
        '0',
        map['created_ts']));
  }

  return posts;
}

checkNull(img, message) {
  if (img != null) {
    return img;
  }

  return message;
}
