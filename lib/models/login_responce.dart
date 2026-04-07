class LoginResponce {
  LoginResponce({
      this.accessToken, 
      this.user,});

  LoginResponce.fromJson(dynamic json) {
    accessToken = json['accessToken'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  String? accessToken;
  User? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accessToken'] = accessToken;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }

}

class User {
  User({
      this.email, 
      this.name, 
      this.id,});

  User.fromJson(dynamic json) {
    email = json['email'];
    name = json['name'];
    id = json['id'];
  }
  String? email;
  String? name;
  int? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['name'] = name;
    map['id'] = id;
    return map;
  }

}