class ModelToken{
  String? token;

  ModelToken({this.token});

  factory ModelToken.fromJson(Map<String, dynamic> json){
    return ModelToken(
      token: json["token"]
    );
  }
}