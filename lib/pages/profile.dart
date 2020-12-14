import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';
import 'posts.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new Profile();
}

class Profile extends State<ProfilePage> {
  //   current_user = 'Welcome \n ' + user.firstname + '' + user.lastname;
  // }

  @override
  Widget build(BuildContext context) {
    final LocalStorage storage = new LocalStorage('User');

    // User user = User.fromJson(storage.getItem("User"));
    // print(user);

    Map<String, dynamic> map = storage.getItem('User');
    // print('after jsondecode');

    User user = User.fromJson(map);
    // print('from json' + user.firstname);

    // storage.setItem('User', map['user']);
    // print('set item,');
    print(user);
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://images.unsplash.com/photo-1546069180-03e8633ef134?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1051&q=80"),
                        fit: BoxFit.cover)),
                child: Container(
                  width: double.infinity,
                  height: 200,
                  child: Container(
                    alignment: Alignment(0.0, 2.5),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://thumbs.dreamstime.com/b/default-avatar-profile-image-vector-social-media-user-icon-potrait-182347582.jpg"),
                      radius: 60.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Text(
                user.firstname + ' ' + user.lastname,
                style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.blueGrey,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'age: ${user.age} ',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black45,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "gender: " + user.gender,
                style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black45,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 10,
              ),
              // s,
              SizedBox(
                height: 15,
              ),
              Text(
                "Your Posts",
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black45,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w300),
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      postcard(),
                      // Expanded(
                      //   child: Column(
                      //     children: [
                      //       Text(
                      //         "Project",
                      //         style: TextStyle(
                      //             color: Colors.blueAccent,
                      //             fontSize: 22.0,
                      //             fontWeight: FontWeight.w600),
                      //       ),
                      //       SizedBox(
                      //         height: 7,
                      //       ),
                      //       Text(
                      //         "15",
                      //         style: TextStyle(
                      //             color: Colors.black,
                      //             fontSize: 22.0,
                      //             fontWeight: FontWeight.w300),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      //   Expanded(
                      //     child: Column(
                      //       children: [
                      //         Text(
                      //           "Followers",
                      //           style: TextStyle(
                      //               color: Colors.blueAccent,
                      //               fontSize: 22.0,
                      //               fontWeight: FontWeight.w600),
                      //         ),
                      //         SizedBox(
                      //           height: 7,
                      //         ),
                      //         Text(
                      //           "2000",
                      //           style: TextStyle(
                      //               color: Colors.black,
                      //               fontSize: 22.0,
                      //               fontWeight: FontWeight.w300),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // RaisedButton(
                  //   onPressed: () {},
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(80.0),
                  //   ),
                  //   child: Ink(
                  //     decoration: BoxDecoration(
                  //       gradient: LinearGradient(
                  //           begin: Alignment.centerLeft,
                  //           end: Alignment.centerRight,
                  //           colors: [Colors.pink, Colors.redAccent]),
                  //       borderRadius: BorderRadius.circular(30.0),
                  //     ),
                  //     child: Container(
                  //       constraints: BoxConstraints(
                  //         maxWidth: 100.0,
                  //         maxHeight: 40.0,
                  //       ),
                  //       alignment: Alignment.center,
                  //       child: Text(
                  //         "Contact me",
                  //         style: TextStyle(
                  //             color: Colors.white,
                  //             fontSize: 12.0,
                  //             letterSpacing: 2.0,
                  //             fontWeight: FontWeight.w300),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // RaisedButton(
                  //   onPressed: () {},
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(80.0),
                  //   ),
                  //   child: Ink(
                  //     decoration: BoxDecoration(
                  //       gradient: LinearGradient(
                  //           begin: Alignment.centerLeft,
                  //           end: Alignment.centerRight,
                  //           colors: [Colors.pink, Colors.redAccent]),
                  //       borderRadius: BorderRadius.circular(80.0),
                  //     ),
                  //     child: Container(
                  //       constraints: BoxConstraints(
                  //         maxWidth: 100.0,
                  //         maxHeight: 40.0,
                  //       ),
                  //       alignment: Alignment.center,
                  //       child: Text(
                  //         "Portfolio",
                  //         style: TextStyle(
                  //             color: Colors.white,
                  //             fontSize: 12.0,
                  //             letterSpacing: 2.0,
                  //             fontWeight: FontWeight.w300),
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              )
            ],
          ),
        ));
  }
}
