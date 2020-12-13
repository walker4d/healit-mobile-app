class News {
  final String name;
  final String title;
  final String thumbnail;
  final String author;
  final String img;

  // NNews.fromJson(Map<String, dynamic> map)
  //     : firstname = map['user']['firstname'],
  //       lastname = map['user']['lastname'],
  //       age = map['user']['age'],
  //       gender = map['user']['gender'];

//Constructor to intitilize
  News(this.name, this.title, this.thumbnail, this.author, this.img);
}
//jsonData["articles"][1]['title'], jsonData["articles"][1]['urlToImage']
