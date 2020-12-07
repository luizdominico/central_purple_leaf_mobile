class Jwt {
  final String token;

  Jwt({this.token});

  factory Jwt.fromJson(Map<String, dynamic> json){
    return Jwt(
      token: json['token']
    );
  }

}