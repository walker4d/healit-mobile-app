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
// import 'utils/news.dart';
import 'pages/news.dart';
import 'models/post.dart';

class NNews {
  String title;
  String image;
  NNews(this.title, this.image);
}

Future<List<NNews>> getNews() async {
  var data = await http.get("http://10.0.2.2:8000/resource/news");

  var jsonData = json.decode(data.body);

  List<NNews> newss = [];
  print(jsonData["author"].length);

  NNews news = new NNews(
      jsonData["author"][0]['title'], jsonData["author"][0]['urlToImage']);
  newss.add(news);
  NNews news1 = new NNews(
      jsonData["author"][1]['title'], jsonData["author"][1]['urlToImage']);
  newss.add(news1);

  NNews news2 = new NNews(
      jsonData["author"][2]['title'], jsonData["author"][2]['urlToImage']);
  newss.add(news2);

  NNews news3 = new NNews(
      jsonData["author"][3]['title'], jsonData["author"][3]['urlToImage']);
  newss.add(news3);

  NNews news4 = new NNews(
      jsonData["author"][4]['title'], jsonData["author"][4]['urlToImage']);

  return newss;
}

Future<List<Post>> getPosts() async {
  var data = await http.get("http://10.0.2.2:8000/posts/");

  var jsonData = json.decode(data.body);

  List<Post> posts = [];

  for (var post in jsonData) {
    Map<String, dynamic> map = post;

    posts.add(Post.fromJson(map));
  }

  return posts;
}

checkNull(img, message) {
  if (img != null) {
    return img;
  }

  return message;
}

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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    int _current = 0;
    var storage = new LocalStorage('User');
    String current_user = '';
    // if (storage.getItem("User") != null) {
    //   Map<String, dynamic> map = jsonDecode(storage.getItem("User"));
    //   print('after jsondecode');

    //   User user = User.fromJson(map);

    //   current_user = 'Welcome \n ' + user.firstname + '' + user.lastname;
    // }

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
                onTap: () => {},
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
                              "Healit",
                              style: TextStyle(
                                  fontSize: 50, fontFamily: "Samantha"),
                            )
                          : Text(
                              'Healit ',
                              style: TextStyle(
                                  fontSize: 50, fontFamily: "Samantha"),
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
                            posts[index].title.substring(1, 4),
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
                            FlatButton(
                              onPressed: () {
                                // Perform some action
                              },
                              child: const Text('comments'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                });
          }));
}

Widget corosal() {}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<http.Response> login(email, password) async {
    var url = 'http://10.0.2.2:8000/login';
    print(url);
    final http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:
            jsonEncode(<String, String>{'email': email, 'password': password}));
    if (response.statusCode == 200) {
      return response;
    } else {
      print('failed to login');
      return null;
    }
  }

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
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'email address',
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

                          User user = User.fromJson(map);
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
                        'Sign in',
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
                      onPressed: () {
                        print(firstname.text);
                        print(passwordController.text);
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

// Widget dropdownOption(){
//  return    DropdownButton<String>(
//       value: dropdownValue,
//       icon: Icon(Icons.arrow_downward),
//       iconSize: 24,
//       elevation: 16,
//       style: TextStyle(color: Colors.deepPurple),
//       underline: Container(
//         height: 2,
//         color: Colors.deepPurpleAccent,
//       ),
//       onChanged: (String newValue) {
//         setState(() {
//           dropdownValue = newValue;
//           print(dropdownValue);

//         });
//       },
//       items: <String>['female', 'male']
//           .map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//     );
// }
