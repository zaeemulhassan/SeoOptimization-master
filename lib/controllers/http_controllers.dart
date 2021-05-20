import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpControllers {
  //* * * * * * *   LOGIN   * * * * * * *
  Future login({String email, String password}) async {
    try {
      final json = jsonEncode({
        "email": "$email",
        "password": "$password",
      });
      var url = Uri.parse('http://139.59.80.110:8189/seo/auth');
      var response = await http
          .post(url, body: json, headers: {"Content-Type": "application/json"});
      debugPrint("Response: " + response.body);
      if (response.statusCode == 200) {
        return [
          {"response": "200", "msg": "${response.body}"}
        ];
      } else {
        return '55';
      }
    } on Exception catch (e) {
      debugPrint("Exception Catched: ${e.toString()}");
      // 55 is the ERR CODE
      return '55';
    }
  }

  //* * * * * * *   Registration * * * * * * *//
  Future registerUser({
    String firstName,
    String lastName,
    String email,
    String location,
    String userName,
    String password,
  }) async {
    try {
      print("data $firstName");
      final json = jsonEncode({
        "first_name": "$firstName",
        "last_name": "$lastName",
        "address": "$location",
        "email": "$email",
        "password": "$password"
      });
      var url = Uri.parse('http://139.59.80.110:8189/seo/register');
      var response = await http
          .post(url, body: json, headers: {"Content-Type": "application/json"});

      print("staty ${response.statusCode}");
      debugPrint("Response: " + response.body);
      if (response.statusCode == 200) {
        return [
          {"response": "200", "msg": "${response.body}"}
        ];

        return response.body;
      } else if (response.statusCode == 409) {
        return "409";
      } else {
        // 33 is the ERR CODE
        return '22';
      }
    } on Exception catch (e) {
      debugPrint("Exception Catched: ${e.toString()}");
      // 55 is the ERR CODE
      return '22';
    }
  }

  //* * * * * * *  Update Password  * * * * * * *//
  Future updatePassword(
      {String oldPassword, String newPassword, String id}) async {
    try {
      final json = jsonEncode({
        "user_id": "$id",
        "old_password": "$oldPassword",
        "new_password": "$newPassword",
      });
      var url = Uri.parse('http://139.59.80.110:8189/seo/password/change');
      var response = await http
          .put(url, body: json, headers: {"Content-Type": "application/json"});

      print(response.statusCode);
      debugPrint("Response: " + response.body);
      if (response.statusCode == 200) {
        return [
          {"response": "200", "msg": "${response.body}"}
        ];
      } else if (response.statusCode == 409) {
        return "409";
      } else {
        // 33 is the ERR CODE
        return '22';
      }
    } on Exception catch (e) {
      debugPrint("Exception Catched: ${e.toString()}");
      // 55 is the ERR CODE
      return '22';
    }
  }

  //* * * * * * *   UpdateProfile   * * * * * * *
  Future updateProfile(
      {String fName,
      String lName,
      String email,
      String address,
      String id}) async {
    try {
      final json = jsonEncode({
        "user_id": "$id",
        "first_name": "$fName",
        "last_name": "$lName",
        "email": "$email",
        "address": "$address"
      });
      var url = Uri.parse('http://139.59.80.110:8189/seo/user/update');
      var response = await http
          .put(url, body: json, headers: {"Content-Type": "application/json"});
      debugPrint("Response: " + response.body);
      print("res ${response.body}");
      if (response.statusCode == 200) {
        return [
          {"response": "200", "msg": "${response.body}"}
        ];
      } else {
        return '55';
      }
    } on Exception catch (e) {
      debugPrint("Exception Catched: ${e.toString()}");
      // 55 is the ERR CODE
      return '55';
    }
  }

  //* * * * * * *   Get Tips   * * * * * * *
  Future getTips({String title, String description}) async {
    try {
      var url = Uri.parse('http://139.59.80.110:8187/seo/tips');
      var response =
          await http.get(url, headers: {"Content-Type": "application/json"});
      debugPrint("Response: " + response.body);
      print("data ${response.body}");
      if (response.statusCode == 200) {
        return response.body;
      } else {
        // 33 is the ERR CODE
        return 'zero';
      }
    } on Exception catch (e) {
      debugPrint("Exception Catched: ${e.toString()}");
      // 55 is the ERR CODE
      return '55';
    }
  }

  //* * * * * * *  Get Profile   * * * * * * *
  Future getProfile({String id}) async {
    try {
      var url = Uri.parse('http://139.59.80.110:8189/seo/profile?user_id=$id');
      var response =
          await http.post(url, headers: {"Content-Type": "application/json"});
      debugPrint("Response: " + response.body);
      print("res ${response.body}");
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return '55';
      }
    } on Exception catch (e) {
      debugPrint("Exception Catched: ${e.toString()}");
      // 55 is the ERR CODE
      return '55';
    }
  }

  //
  //* * * * * * *   Get Page Rank   * * * * * * *
  Future getRank({String domain}) async {
    try {
      var url = Uri.parse(
          'https://openpagerank.com/api/v1.0/getPageRank?domains[]=$domain');
      var response = await http.get(url,
          headers: {"API-OPR": "g8o48gkkkw8kw4cogssg44ksokg8kwwgscksow4k"});
      debugPrint("Response: " + response.body);
      print("data ${response.body}");
      Map<String, dynamic> map = jsonDecode(response.body);
      var result = map["response"];
      print("map $result");
      if (response.statusCode == 200) {
        return result;
      } else {
        // 33 is the ERR CODE
        return 'zero';
      }
    } on Exception catch (e) {
      debugPrint("Exception Catched: ${e.toString()}");
      // 55 is the ERR CODE
      return '55';
    }
  }
  //* * * * * * *   Add Discussion   * * * * * * *
  Future addDiscussion({String name, String message}) async {
    try {
      final json = jsonEncode({
        "name": "$name",
        "message": "$message",
      });
      var url = Uri.parse('http://139.59.80.110:8188/seo/discuss');
      var response = await http
          .post(url, body: json, headers: {"Content-Type": "application/json"});
      debugPrint("Response: " + response.body);
      print("res ${response.body}");
      if (response.statusCode == 200) {
        return [
          {"response": "200", "msg": "${response.body}"}
        ];
      } else {
        return '55';
      }
    } on Exception catch (e) {
      debugPrint("Exception Catched: ${e.toString()}");
      // 55 is the ERR CODE
      return '55';
    }
  }
  //* * * * * * *   Get Discussion   * * * * * * *
  Future getDiscussion() async {
    try {
      var url = Uri.parse('http://139.59.80.110:8188/seo/discussions');
      var response =
      await http.get(url, headers: {"Content-Type": "application/json"});
      debugPrint("Response: " + response.body);
      print("data ${response.body}");
      if (response.statusCode == 200) {
        return response.body;
      } else {
        // 33 is the ERR CODE
        return 'zero';
      }
    } on Exception catch (e) {
      debugPrint("Exception Catched: ${e.toString()}");
      // 55 is the ERR CODE
      return '55';
    }
  }
}
