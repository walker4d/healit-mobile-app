import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'models/user.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'pages/login.dart';
import 'pages/profile.dart';
import 'pages/news.dart';
import 'pages/posts.dart';

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Text(
                          'Covid19 statistic in jamaica \ndeath: 259 \nrecover: 6,61 \ncases: 10,909',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ))
    .toList();
final List<String> imgList = [
  'https://cdnph.upi.com/collection/ph/upi/12402/b39aeae389e9b9589a046f7e95a0e7d5/Scenes-from-a-pandemic-World-copes-with-COVID-19_2_1.jpg',
  'https://cdnph.upi.com/collection/ph/upi/12402/8dc6924e860f2a9e23a204a735fdb5e5/Scenes-from-a-pandemic-World-copes-with-COVID-19_5_1.jpg',
  'https://media.wired.com/photos/5fc6b6f18a7caca6d23c3555/16:9/w_496,c_limit/Science_vaccine_1250956760.jpg',
  'https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/article_thumbnails/slideshows/ginger_health_benefits_slideshow/1800x1200_ginger_health_benefits_slideshow.jpg',
  'https://primaryreporting.who-umc.org/Content/Images/Logos/jm.png'
];

// final List<String> title = [
//   'Courtney Farr did not hide his frustration when he penned the obituary describing the days his father spent struggling with the virus without the comfort of familiar faces',
//   'BYU study shows some alcohol-free hand sanitizers effective at fighting COVID-19 - KSL.com',
//   'Since the pandemic began, many people in the U.S. have operated under the assumption that for a hand sanitizer to be effective at combating the novel coronavirus, it must contain at least the CDC recommended 60% alcohol.',
//   'Amid the second wave of the coronavirus pandemic, Chief Veterinary Officer Christine Middlemiss in the United Kingdom tweeted a warning about bird flu after a H5N8 strain was found at a turkey farm in northern England.',
//   'A nursing home in Moore County has reported a coronavirus outbreak, with 48 residents and 10 staff members confirmed positive.'
// ];
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Application name
      title: 'Flutter Stateful Clicker Counter',
      theme: ThemeData(
        // Application theme data, you can set the colors for the application as
        // you want
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Flutter Demo Clicker Counter Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    int _current = 0;
    final LocalStorage storage = new LocalStorage('User');
    User user = null;
    Map<String, dynamic> map = storage.getItem('User');
    if (storage.getItem('User') != null) {
      user = User.fromJson(map);
    }
    return Scaffold(
        key: _scaffoldKey,
        drawer: new Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: storage.getItem("User") == null
                    ? Text(
                        'Healit',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      )
                    : Text(
                        'Healit\n\n\n welcome ' +
                            user.firstname +
                            ' ' +
                            user.lastname,
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
                onTap: () => {},
              ),
              // ListTile(
              //   leading: Icon(Icons.border_color),
              //   title: Text('self diagnostic '),
              //   onTap: () => {Navigator.of(context).pop()},
              // ),
              storage.getItem("User") != null
                  ? ListTile(
                      leading: Icon(Icons.verified_user),
                      title: Text('Profile'),
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage()),
                        ),
                      },
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
                      onTap: () => {user = null, storage.deleteItem('User')},
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
                      Text(
                        'Healit',
                        style: TextStyle(fontSize: 50, fontFamily: "Samantha"),
                      ),
                      IconButton(icon: Icon(Icons.add), onPressed: () {})
                    ],
                  ),
                ),
                Column(children: [
                  CarouselSlider(
                    items: imageSliders,
                    options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: true,
                        aspectRatio: 2.0,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imgList.map((url) {
                      int index = imgList.indexOf(url);
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == index
                              ? Color.fromRGBO(0, 0, 0, 0.9)
                              : Color.fromRGBO(0, 0, 0, 0.4),
                        ),
                      );
                    }).toList(),
                  ),
                  ListTile(
                    title: const Text("News on health"),
                    subtitle: const Text('All related health topic'),
                    trailing: Icon(Icons.arrow_right),
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NewsFeed()),
                      )
                    },
                  ),
                  //  Postcard(),
                  postcard(),
                ]),
              ],
            ),
          )),
        ));
  }
}
