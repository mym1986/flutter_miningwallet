import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class CoinRepository{

  //집
  // static String mainUrl = "http://192.168.35.229:18001/api/v1";
  //사무실
  // static String mainUrl = "http://192.168.0.33:18001/api/v1";
  //운영
  static String mainUrl = "http://183.111.67.189:18001/api/v1";

  Uri createWalletUrl = Uri.parse('$mainUrl/tron/createWallet');
  Uri getBalanceUrl = Uri.parse('$mainUrl/tron/getBalance');
  Uri sendTokenUrl = Uri.parse('$mainUrl/tron/sendToken');
  Uri sendTransactionUrl = Uri.parse('$mainUrl/tron/sendTransaction');
  Uri updateMiningUrl = Uri.parse('$mainUrl/mining/updateMiningStatus');
  Uri getMiningUrl = Uri.parse('$mainUrl/mining/getMiningStatus');
  Uri getMiningTop100Url = Uri.parse('$mainUrl/mining/getMiningTop100');
  Uri getMiningHistoryUrl = Uri.parse('$mainUrl/mining/getMiningHistory');

  static const Map<String, String> _JSON_HEADERS = {
    "content-type": "application/json"
  };

  Future<Map> updateMining(String email, double miningAmount)async{
    var data = {
      "email": email, "miningAmount": miningAmount
    };
    var body = json.encode(data);
    http.Response response = await http.Client().post(updateMiningUrl, headers: _JSON_HEADERS,
        body: body);
    print(response);
    try {

      //List data = jsonDecode(response.body);
      Map<String, dynamic> map = json.decode(response.body);
      double miningValue = map["data"]["miningValue"];
      double amount = map["data"]["amount"];
      int todayCount = map["data"]["todayCount"];
      double recommendAmount = map["data"]["recommendAmount"];
      Map<String, String> resultMap = {"miningValue" : miningValue.toString(), "amount" : amount.toString(), "todayCount" : todayCount.toString(), "recommendAmount" : recommendAmount.toString()};
      return resultMap;
    } catch (exception) {
      print(response.body);
      throw ('An error occurred');
    }
    //return response.data["user"];
  }

  Future<Map> getMining(String email, double miningAmount)async{
    var data = {
      "email": email, "miningAmount": miningAmount
    };
    var body = json.encode(data);
    http.Response response = await http.Client().post(getMiningUrl, headers: _JSON_HEADERS,
        body: body);
    print(response);
    try {

      //List data = jsonDecode(response.body);
      Map<String, dynamic> map = json.decode(response.body);
      double miningValue = map["data"]["miningValue"];
      double amount = map["data"]["amount"];
      int todayCount = map["data"]["todayCount"];
      double recommendAmount = map["data"]["recommendAmount"];
      Map<String, String> resultMap =
        {"miningValue" : miningValue.toString(), "amount" : amount.toString(),
          "todayCount" : todayCount.toString(), "recommendAmount" : recommendAmount.toString()};
      return resultMap;
    } catch (exception) {
      print(response.body);
      throw ('An error occurred');
    }
    //return response.data["user"];
  }

  Future<Map> getBalance(String email)async{
    var data = {
      "email": email
    };
    var body = json.encode(data);
    http.Response response = await http.Client().post(getBalanceUrl, headers: _JSON_HEADERS,
        body: body);
    print(response);
    try {

      //List data = jsonDecode(response.body);
      Map<String, dynamic> map = json.decode(response.body);
      String tronBalance = map["data"]["tronBalance"];
      String gmcBalance = map["data"]["gmcBalance"];
      Map<String, String> resultMap = {"tronBalance" : tronBalance, "gmcBalance" : gmcBalance};
      return resultMap;
    } catch (exception) {
      print(response.body);
      throw ('An error occurred');
    }
    //return response.data["user"];
  }

  Future<Map> getWallet(String email)async{
    var data = {
      "email": email
    };
    var body = json.encode(data);
    http.Response response = await http.Client().post(createWalletUrl, headers: _JSON_HEADERS,
        body: body);
    print(response);
    try {

      //List data = jsonDecode(response.body);
      Map<String, dynamic> map = json.decode(response.body);
      String address = map["data"]["address"];
      Map<String, String> resultMap = {"address" : address};
      return resultMap;
    } catch (exception) {
      print(response.body);
      throw ('An error occurred');
    }
    //return response.data["user"];
  }

  Future<bool> sendToken(String email, String toAddress, double amount)async{
    var data = {
      "email": email, "toAddress" : toAddress, "amount": amount
    };
    var body = json.encode(data);
    http.Response response = await http.Client().post(sendTokenUrl, headers: _JSON_HEADERS,
        body: body);
    print(response);
    try {

      //List data = jsonDecode(response.body);
      Map<String, dynamic> map = json.decode(response.body);
      bool isSend = map["data"]["send"];
      return isSend;
    } catch (exception) {
      print(response.body);
      throw ('An error occurred');
    }
    //return response.data["user"];
  }

  Future<bool> sendTransaction(String email, String toAddress, double amount)async{
    var data = {
      "email": email, "toAddress" : toAddress, "amount": amount
    };
    var body = json.encode(data);
    http.Response response = await http.Client().post(sendTransactionUrl, headers: _JSON_HEADERS,
        body: body);
    print(response);
    try {

      //List data = jsonDecode(response.body);
      Map<String, dynamic> map = json.decode(response.body);
      bool isSend = map["data"]["send"];
      return isSend;
    } catch (exception) {
      print(response.body);
      throw ('An error occurred');
    }
    //return response.data["user"];
  }

  Future<List> getTop100()async{
    http.Response response = await http.Client().post(getMiningTop100Url, headers: _JSON_HEADERS, body: null);
    print(response);
    try {

      //List data = jsonDecode(response.body);
      Map<String, dynamic> map = json.decode(response.body);
      List list = map["data"];
      return list;
    } catch (exception) {
      print(response.body);
      throw ('An error occurred');
    }
    //return response.data["user"];
  }

  Future<List> getMiningHistory(String email)async{
    var data = {
      "email": email
    };
    var body = json.encode(data);
    http.Response response = await http.Client().post(getMiningHistoryUrl, headers: _JSON_HEADERS,
        body: body);
    try {

      //List data = jsonDecode(response.body);
      Map<String, dynamic> map = json.decode(response.body);
      List list = map["data"];
      return list;
    } catch (exception) {
      print(response.body);
      throw ('An error occurred');
    }
    //return response.data["user"];
  }

}