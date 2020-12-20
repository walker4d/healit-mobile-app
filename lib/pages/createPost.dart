import 'dart:io';

import 'package:click_counter/models/user.dart';
import 'package:click_counter/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:select_dialog/select_dialog.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:localstorage/localstorage.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';

import '../main.dart';

import 'login.dart';

class CreatePost extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<CreatePost> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  TextEditingController tags = TextEditingController();
  String authorName, titles, desc;
  String dropdownValue = 'Report/Complaint';
  String image;
  File selectedImage;
  bool _isLoading = false;

  String imageUrl = '';

  bool isloading = false;
  Future uploadImage() async {
    const url = "https://api.cloudinary.com/v1_1/healit/image/upload";
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      isloading = true;
    });

    Dio dio = Dio();
    FormData formData = new FormData.fromMap({
      "file": await MultipartFile.fromFile(
        image.path,
      ),
      "upload_preset": "healit",
      "cloud_name": "healit",
    });
    try {
      Response response = await dio.post(url, data: formData);

      var data = jsonDecode(response.toString());
      print(data['secure_url']);

      setState(() {
        isloading = false;
        imageUrl = data['secure_url'];
      });
    } catch (e) {
      print(e);
    }
  }

  uploadBlog() async {
    if (selectedImage != null) {
      setState(() {
        isloading = true;
      });
    } else {}
  }

  Future<http.Response> Create(title, description) async {
    final LocalStorage storage = new LocalStorage('User');
    Map<String, dynamic> map = storage.getItem('User');
    User user = User.fromJson(map);
    var url = 'http://10.0.2.2:8000/posts/create';
     var map1 = Map.fromIterable(ex5, value: (e) => e);
                          print(map1);
    print(url);
    final http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'Title': title,
          'Description': description,
          'image': imageUrl,
          'Tags': ['mobile'],
          'userid': user.id,
          'Author': user.firstname + ' ' + user.lastname
        }));
    if (response.statusCode == 200) {
      return response;
    } else {
      print('failed to login');
      return null;
    }
  }

  List<String> ex5 = [];

  // final modelItems = List.generate(50, (index) => 'hi');
  final List<String> Tags = ['Post', 'NSFW', 'Info', 'Feedback', 'Discussion'];
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var storage = new LocalStorage('User');
    File selectedImage;
    bool _isLoading = false;

    String current_user = '';

    return Scaffold(
        appBar: AppBar(
          title: Text('create - Post'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Create Post',
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
                GestureDetector(
                    onTap: () async {
                      print('tap');
                      await uploadImage();
                    },
                    child: imageUrl != ''
                        ? Container(
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            height: 170,
                            width: MediaQuery.of(context).size.width,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            height: 170,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6)),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo,
                                  color: Colors.black45,
                                ),
                                Text("Tap to select image.")
                              ],
                            ),
                          )),
                SizedBox(
                  height: 8,
                ),
                RaisedButton(
                  child: Text(
                    ex5.isEmpty ? "Multiple Items Example" : ex5.join(", "),
                  ),
                  onPressed: () {
                    SelectDialog.showModal<String>(
                      context,
                      label: "Multiple Items Example",
                      multipleSelectedValues: ex5,
                      items: Tags,
                      itemBuilder: (context, item, isSelected) {
                        return ListTile(
                          trailing: isSelected ? Icon(Icons.check) : null,
                          title: Text(item),
                          selected: isSelected,
                        );
                      },
                      onMultipleItemsChange: (List<String> selected) {
                        setState(() {
                          print(selected);
                          ex5 = selected;
                         
                        });
                      },
                      okButtonBuilder: (context, onPressed) {
                        return Align(
                          alignment: Alignment.centerRight,
                          child: FloatingActionButton(
                            onPressed: onPressed,
                            child: Icon(Icons.check),
                            mini: true,
                          ),
                        );
                      },
                    );
                  },
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.green,
                      child: Text('Create Post'),
                      onPressed: () async {
                        http.Response response =
                            await Create(title.text, description.text);

                        if (response != null) {
                          
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyApp()),
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
              ],
            )));
  }
}
