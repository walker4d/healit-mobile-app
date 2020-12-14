import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'signup.dart';
import '../main.dart';

class SignupPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _signup();
}

class _signup extends State<SignupPage> {
  TextEditingController lastname = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController eamilController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

  Future<http.Response> SignupPage(email, password, firstname, lastname) async {
    var url = 'http://10.0.2.2:8000/register';

    print(url);
    final http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
          'firstname': firstname,
          'lastname': lastname,
          'age': '0',
          'gender': ''
        }));
    if (response.statusCode == 200) {
      return response;
    } else {
      print('failed to Signup');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('signup'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'sign in to healit',
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: firstname,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'first name',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: lastname,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'last Name',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: eamilController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'email',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'confirm Password',
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
                      child: Text('Sign up'),
                      onPressed: () async {
                        if (passwordController.text ==
                            confirmPasswordController.text) {
                          http.Response response = await SignupPage(
                              eamilController.text,
                              passwordController.text,
                              firstname.text,
                              lastname.text);

                          if (response != null) {
                            print('signed up!!');
                          } else {}
                        }
                      },
                    )),
                Container(
                    child: Row(
                  children: <Widget>[
                    Text('have account?'),
                    FlatButton(
                      textColor: Colors.green,
                      child: Text(
                        'login in',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {},
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ))
              ],
            )));
  }
}
