import 'package:flutter/cupertino.dart';
import 'package:flutterapi/APIs/api.dart';
import 'package:flutterapi/models/dartmodel.dart';

class user_provider extends ChangeNotifier {
  final home_pis homeApi =
      home_pis(); // Assuming HomeApi is the correct class name
  List<userdata> userData = []; // Initialize userData as an empty list

  Future<List<userdata>> getUserData() async {
    try {
      userData = await homeApi.fetchData();
      print("User data fetched successfully: $userData");
    } catch (e) {
      print("Error fetching user data: $e");
    }

    return userData;
  }

  Future deleteUser(id) async {
    try {
      print(id);
      final userDatas = await homeApi.deleteData(id);
      print("User data fetched successfully: $userData");
      if (userDatas == "success") {
        notifyListeners();
        return "success";
      } else {
        return "error";
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  createUser(id) async {
    try {
      print(id);
      final userDatas = await homeApi.createUser(id);
      print("User data fetched successfully: $userData");
      if (userDatas == "success") {
        notifyListeners();
        return "success";
      } else {
        return "error";
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  updateUser(data, id) async {
    try {
      print(id);
      final userDatas = await homeApi.updateUser(data, id);
      print("User data fetched successfully: $userData");
      if (userDatas == "success") {
        notifyListeners();
        return "success";
      } else {
        return "error";
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }
}
