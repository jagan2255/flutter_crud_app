import 'dart:convert';
import 'package:flutterapi/models/dartmodel.dart';
import 'package:http/http.dart' as http;

class home_pis {
  final client = http.Client();

  late userdata userModel;

  Future<List<userdata>> fetchData() async {
    List<userdata> userList = [];

    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:3000/getall'));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        List<userdata> userList = responseData
            .map((userData) => userdata.fromJson(userData))
            .toList();
        return userList;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future deleteData(id) async {
    try {
      final response =
          await http.delete(Uri.parse('http://10.0.2.2:3000/deleteuser/$id'));

      if (response.statusCode == 200) {
        return "success";
      } else {
        throw Exception('Failed to load data');
      }
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<String> createUser(userdata data) async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/adduser'),
        body: json.encode(data.toJson()), // Serialize userdata object to JSON
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        return "success";
      } else {
        throw Exception('Failed to update data');
      }
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<String> updateUser(userdata data, id) async {
    try {
      final response = await http.put(
        Uri.parse('http://10.0.2.2:3000/updateuser/$id'),
        body: json.encode(data.toJson()), // Serialize userdata object to JSON
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        return "success";
      } else {
        throw Exception('Failed to update data');
      }
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}
