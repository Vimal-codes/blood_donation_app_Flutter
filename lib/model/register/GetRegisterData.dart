import 'Data.dart';
import 'Tokens.dart';
import 'dart:convert';

GetRegisterData getRegisterDataFromJson(String str) => GetRegisterData.fromJson(json.decode(str));
String getRegisterDataToJson(GetRegisterData data) => json.encode(data.toJson());
class GetRegisterData {
  GetRegisterData({
      this.status, 
      this.msg, 
      this.data, 
      this.tokens,});

  GetRegisterData.fromJson(dynamic json) {
    status = json['Status'];
    msg = json['Msg'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    tokens = json['tokens'] != null ? Tokens.fromJson(json['tokens']) : null;
  }
  String? status;
  String? msg;
  Data? data;
  Tokens? tokens;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = status;
    map['Msg'] = msg;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    if (tokens != null) {
      map['tokens'] = tokens?.toJson();
    }
    return map;
  }

}