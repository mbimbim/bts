import 'dart:convert';
import 'dart:io';

import 'package:bts/LinkAPi.dart';
import 'package:bts/Model/ModelToken.dart';
import 'package:bts/View/Home.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class ServiceApiLoginRegister extends GetxController{
  RxString title = "Login".obs;

  LINKAPI linkapi = LINKAPI();
  ModelToken token = ModelToken();

  statuslogin(String titles){
    if(titles == "Login"){
      title.value = "Login";
    }else{
      title.value = "Register";
    }

    title.refresh();

  }


   Future<void> Login(String username, password) async {
    title.value = "Login";
    title.refresh();
    print(title.value);
 var url = Uri.parse("${LINKAPI.BASEURL}login");
var body = jsonEncode({
  "username": username,
  "password": password
});

var response = await http.post(
  url,
  headers: {"Content-Type": "application/json"},
  body: body,
);

var responseJson = jsonDecode(response.body);
    print('Response status login: ${response.statusCode}');
    print('Response body login: ${response.body}');
   print('tokennya : ' + responseJson["data"]["token"]);

   if(response.statusCode == 200){
     Get.snackbar("Login", "Berhasil Login");
     token = ModelToken.fromJson(responseJson["data"]);
     update();
     //print('dapat ' + token.token.toString());
     Get.to(Home());
  }else{
    Get.snackbar("Login", "Gagal Login");
  }
   }

  Future<void> Register(String username, password, email) async {
    title.value = "Register";
    title.refresh();
    print(title.value);
var url = Uri.parse("${LINKAPI.BASEURL}register");
var body = jsonEncode({
  "username": username,
  "password": password,
  "email": email
});

print('kiriman : ' + body);

var response = await http.post(
  url,
  headers: {"Content-Type": "application/json"},
  body: body,
);
    print('Response status regis: ${response.statusCode}');
    print('Response body regis: ${response.body}');

  }
}