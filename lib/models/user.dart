import 'package:localstorage/localstorage.dart';

class User {
  String firstname;
  String lastname;
  String gender;
  int age;

  User.fromJson(Map<String, dynamic> map)
      : firstname = map['user']['firstname'],
        lastname = map['user']['lastname'],
        age = map['user']['age'],
        gender = map['user']['gender'];

  // Map<String, dynamic> toJson() =>
  //   {
  //     'name': name,
  //     'email': email,
  //   };

  User(this.firstname, this.lastname, this.age, this.gender);
}
