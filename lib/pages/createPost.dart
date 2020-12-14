import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

import '../main.dart';

import 'login.dart';

class CreatePost extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<CreatePost> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var storage = new LocalStorage('User');
    String current_user = '';

    return Scaffold(
      key: _scaffoldKey,
      drawer: new Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Healit',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              decoration: BoxDecoration(
                  color: Colors.green,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/cover.jpg'))),
            ),
            ListTile(
              leading: Icon(Icons.input),
              title: Text('Home'),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                )
              },
            ),
            ListTile(
              leading: Icon(Icons.border_color),
              title: Text('self diagnostic '),
              onTap: () => {Navigator.of(context).pop()},
            ),
            storage.getItem("User") != null
                ? ListTile(
                    leading: Icon(Icons.verified_user),
                    title: Text('Profile'),
                    onTap: () => {Navigator.of(context).pop()},
                  )
                : ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Login'),
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      ),
                    },
                  ),
            storage.getItem("User") == null
                ? ListTile()
                : ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Logout'),
                    onTap: () => {storage.deleteItem('User')},
                  ),
          ],
        ),
      ),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: () => _scaffoldKey.currentState.openDrawer(),
                      ),
                      storage.getItem("User") == null
                          ? Text(
                              "Healit- Create",
                              style: TextStyle(
                                  fontSize: 30, fontFamily: "Samantha"),
                            )
                          : Text(
                              'Healit-  Create',
                              style: TextStyle(
                                  fontSize: 30, fontFamily: "Samantha"),
                            ),
                      IconButton(icon: Icon(Icons.add), onPressed: () {})
                    ],
                  ),
                ),
                Column(
                  children: [
// Postcard(),
                    CreateForm(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
              child: const Text('dislike 1'),
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

Future<http.Response> Create(email, password) async {
  var url = 'http://10.0.2.2:8000/login';
  print(url);
  final http.Response response = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email, 'password': password}));
  if (response.statusCode == 200) {
    return response;
  } else {
    print('failed to login');
    return null;
  }
}

Widget CreateForm() {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController image = TextEditingController();

  TextEditingController tags = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Login to healit',
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: title,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'enter the title',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: description,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'enter description',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: title,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'enter the title',
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    //forgot password screen
                  },
                  textColor: Colors.green,
                  child: Text('Forgot Password'),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.green,
                      child: Text('Login'),
                      onPressed: () async {
                        print(nameController.text);
                        print(passwordController.text);
                        http.Response response = await login(
                            nameController.text, passwordController.text);
                        print('after login');
                        if (response != null) {
                          final LocalStorage storage = new LocalStorage('User');

                          Map<String, dynamic> map = jsonDecode(response.body);
                          print('after jsondecode');

                          User user = User.fromJson(map['user']);
                          print('from json' + user.firstname);

                          storage.setItem('User', map['user']);
                          print('set item,');
                          print(storage.getItem('User'));
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyApp()),
                          );
                          AlertDialog(
                            title: Text("login was succes"),
                            content: Text(
                                "Would you like to continue learning how to use Flutter alerts?"),
                            actions: [
                              FlatButton(
                                child: Text("Continue"),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyApp()),
                                  );
                                },
                              )
                            ],
                          );
                        } else {
                          return AlertDialog(
                            title: Text("login failed"),
                            content: Text("please check your inputa"),
                            actions: [],
                          );
                        }
                      },
                    )),
                Container(
                    child: Row(
                  children: <Widget>[
                    Text('Does not have account?'),
                    FlatButton(
                      textColor: Colors.green,
                      child: Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignupPage()),
                        );
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ))
              ],
            )));
  }
}
