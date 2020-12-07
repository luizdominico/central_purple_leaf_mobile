class User {
  final String username;
  final String fullname;
  final String email;
  final String password;
  final String birthdate;

  User({this.username, this.fullname, this.email, this.password, this.birthdate});

  factory User.fromJson(Map<String, dynamic> json){
    return User(
        username: json['username'],
        fullname: json['fullname'],
        email: json['email'],
        password: json['password'],
        birthdate: json['birthdate'],
    );
  }

}