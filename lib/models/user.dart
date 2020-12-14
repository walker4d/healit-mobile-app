import 'package:localstorage/localstorage.dart';

class User {
  String id;
  String firstname;
  String lastname;
  String gender;
  int age;

  User.fromJson(Map<String, dynamic> map)
      : firstname = map['firstname'],
        lastname = map['lastname'],
        age = map['age'],
        id = map['_id'],
        gender = map['gender'];

  // Map<String, dynamic> toJson() =>
  //   {
  //     'name': name,
  //     'email': email,
  //   };

  User(this.firstname, this.lastname, this.age, this.id, this.gender);
}
