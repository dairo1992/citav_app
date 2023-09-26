import 'package:flutter/foundation.dart';

class User extends ChangeNotifier {
  String? username;
  String? name;
  String? id;
  String? token;

  void updateUser({
    String? username,
    String? name,
    String? id,
    String? token,
  }) {
    this.username = username;
    this.name = name;
    this.id = id;
    this.token = token;
    notifyListeners();
  }
}
