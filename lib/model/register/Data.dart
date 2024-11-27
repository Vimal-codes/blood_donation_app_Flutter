import 'dart:convert';

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      this.id, 
      this.name, 
      this.phone, 
      this.place, 
      this.pincode, 
      this.email,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    place = json['place'];
    pincode = json['pincode'];
    email = json['email'];
  }
  num? id;
  String? name;
  num? phone;
  String? place;
  num? pincode;
  String? email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['phone'] = phone;
    map['place'] = place;
    map['pincode'] = pincode;
    map['email'] = email;
    return map;
  }

}