import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class UserRepository{
  // static String mainUrl = "https://reqres.in";
  // var loginUrl = "$mainUrl/api/login";

  //집
  // static String mainUrl = "http://192.168.35.229:18001/api/v1";
  //사무실
  static String mainUrl = "http://192.168.0.33:18001/api/v1";
  //운영
  // static String mainUrl = "http://183.111.67.189:18001/api/v1";
  Uri loginUrl = Uri.parse('$mainUrl/users/signIn');
  Uri signUpUrl = Uri.parse('$mainUrl/users/signUp');
  Uri changePasswordUrl = Uri.parse('$mainUrl/users/changePassword');
  Uri getUserUrl = Uri.parse('$mainUrl/users/getUser');

  final FlutterSecureStorage storage = FlutterSecureStorage();
  final Dio _dio = Dio();

  Future<bool> hasUser() async{
    var value = await storage.read(key: 'User');
    if(value != null){
      return true;
    }else{
      return false;
    }
  }

  Future<String> getUser(String email) async{
    var data = {
      "email": email
    };
    var body = json.encode(data);
    http.Response response = await http.Client().post(getUserUrl, headers: _JSON_HEADERS, body: body);
    try {

      //List data = jsonDecode(response.body);
      Map<String, dynamic> map = json.decode(response.body);

      return map["data"]["email"];
    } catch (exception) {
      print(response.body);
      throw ('An error occurred');
    }
  }

  Future<String> changePassword(String email, String oldPassword, String password, String confirmPassword) async{
    var data = {
      "email": email,
      "oldPassword": oldPassword,
      "password": password,
      "confirmPassword": confirmPassword
    };
    var body = json.encode(data);

    http.Response response = await http.Client().post(loginUrl, headers: _JSON_HEADERS, body: body);

    try {

      //List data = jsonDecode(response.body);
      Map<String, dynamic> map = json.decode(response.body);

      return map["data"]["email"];
    } catch (exception) {
      print(response.body);
      throw ('An error occurred');
    }
    //return response.data["user"];
  }

  Future<void> persisteUser(String user) async{
    await storage.write(key: 'User', value: user);
  }
  
  Future<void> deleteUser() async {
    storage.delete(key: 'User');
    storage.deleteAll();
  }

  static const Map<String, String> _JSON_HEADERS = {
    "content-type": "application/json;charset=UTF-8"
  };

  Future<String> login(String email, String password)async{
    var data = {
      "email": email,
      "password": password
    };
    var body = json.encode(data);
    http.Response response = await http.Client().post(loginUrl, headers: _JSON_HEADERS,
        body: body);
    print(response);
    try {

      //List data = jsonDecode(response.body);
      Map<String, dynamic> map = json.decode(response.body);
      await persisteUser(map["data"]["email"]);

      // String value = await storage.read(key: "User");
      //
      // print(value);
      return map["data"]["email"];
    } catch (exception) {
      print(response.body);
      throw ('An error occurred');
    }
    //return response.data["user"];
  }

  Future<String> signUp(String email, String password, String phoneNumber, String confirmPassword,
      String pin, String recommender, String userId)async{
    var data = {
      "email": email,
      "password": password,
      "confirmPassword": confirmPassword,
      "phone": phoneNumber,
      "pin": pin,
      "recommender": recommender,
      "userId": userId,
    };
    var body = json.encode(data);
    http.Response response = await http.Client().post(signUpUrl, headers: _JSON_HEADERS, body: body);

    try {

      //List data = jsonDecode(response.body);
      Map<String, dynamic> map = json.decode(response.body);
      await persisteUser(map["data"]["email"]);

      return map["data"]["email"];
    } catch (exception) {
      print(response.body);
      throw ('An error occurred');
    }
    //return response.data["user"];
  }

}