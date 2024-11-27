import 'dart:convert';

Tokens tokensFromJson(String str) => Tokens.fromJson(json.decode(str));
String tokensToJson(Tokens data) => json.encode(data.toJson());
class Tokens {
  Tokens({
      this.access, 
      this.refresh,});

  Tokens.fromJson(dynamic json) {
    access = json['access'];
    refresh = json['refresh'];
  }
  String? access;
  String? refresh;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['access'] = access;
    map['refresh'] = refresh;
    return map;
  }

}