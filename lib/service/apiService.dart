import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:blood_donation_app_flutter/service/SharedPref.dart';
import 'package:http/http.dart' as http;

import '../model/login/GetLoginData.dart';

class ApiService{
  final baseUrl = "https://freeapi.luminartechnohub.com";

  Future<GetLoginData?> login(String email, String password) async {
    var url = Uri.parse("$baseUrl/login");

    var header = {
      'accept': 'application/json',
      'Content-Type': 'application/json'
    };

    var body = jsonEncode(
        {
          'email' :  email,
          'password' : password
        }
    );

    try{
      final response = await http.post(url, headers: header, body: body);
      if(response.statusCode >= 200 && response.statusCode <= 299){
        var responseData = jsonDecode(response.body);
        return GetLoginData.fromJson(responseData);
      }
    }catch (e){
      print("$e");
    }
  }

  Future<bool> registration(String name, int phone, String place, int pincode, String email, String password) async {
    var url = Uri.parse("$baseUrl/registration/");

    var header = {
      'accept': 'application/json',
      'Content-Type': 'application/json'
    };

    var body = jsonEncode({
      "name": name,
      "phone": phone,
      "place": place,
      "pincode": pincode,
      "email": email,
      "password": password
    });

    try {
      final response = await http.post(url, headers: header, body: body);

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        print("Registration successful: ${response.body}");
        return true; // Registration was successful
      } else {
        // Handle non-200 responses
        print("Registration failed with status: ${response.statusCode}");
        print("Response body: ${response.body}");
        return false; // Registration failed
      }
    } catch (e) {
      // Log exception
      print("Registration error: $e");
      return false; // Registration failed due to an exception
    }
  }

}