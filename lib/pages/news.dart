import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../main.dart';
import  '../models/news.dart';

class NewsFeed extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}
class _State extends State<NewsFeed> {
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
                onTap: () => {  Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyHomePage()),
                        )},
              ),
              
              ListTile(
                leading: Icon(Icons.border_color),
                title: Text('self diagnostic '),
                onTap: () => {Navigator.of(context).pop()},
              ),
               storage.getItem("User") != null
                  ?   ListTile(
                leading: Icon(Icons.verified_user),
                title: Text('Profile'),
                onTap: () => { Navigator.of(context).pop()},
              ): ListTile(
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
                  ? ListTile(
                     
                    )
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
                        "Healit- Lastest News",
                        style: TextStyle(fontSize: 50, fontFamily: "Samantha"),
                      ):Text(
                        'Healit- Lastest News',
                        style: TextStyle(fontSize: 30, fontFamily: "Samantha"),
                      ),
                      IconButton(icon: Icon(Icons.add), onPressed: () {

                        
                      })
                    ],
                  ),
                ),
                Column(
                  
                  children: [
// Postcard(),
_GetNews(),
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

_GetNews() {
 
  return 
  Container(
        constraints: BoxConstraints(
          minHeight: 50.0,
          maxHeight: 800.0,
        ),
        child:FutureBuilder(
      future: getNews(),
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
        List<NNews> news = snapshot.data;

        return ListView.builder(
            // scrollDirection: Axis.vertical,
            itemCount: news.length,
            itemBuilder: ( BuildContext context, int index) {
              return Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.arrow_drop_down_circle),
                      title:  Text(news[index].author != null ? news[index].author: 'unkown author'),
                      subtitle: Text(
                        news[index].title,
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                    Image.network(news[index].image),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                      news[index].description,
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                 
                  ],
                ),
              );
            });
      }));

}


Future<List<NNews>> getNews() async {
  var data = await http.get("http://10.0.2.2:8000/resource/news");

  var jsonData = json.decode(data.body);

  List<NNews> newss = [];
  for (var item in jsonData["articles"]) {

 NNews news = new NNews(
      item['title'], item['urlToImage'],item['publishedAt'],item['description'],item['author']);

newss.add(news);
  }

  return newss;
}

class NNews {
  String title;
  String image;
  String description;
  String publishedAt;
  String author;

  NNews(this.title, this.image,this.publishedAt,this.description,this.author);

  
}