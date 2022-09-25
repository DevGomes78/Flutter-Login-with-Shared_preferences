import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/string_constants_login.dart';
import '../models/user_service_models.dart';

class SaveUser{
   saveUser(UserModel userModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
      StringConstants.loguinUserInfos,
      json.encode(userModel.toJson()),
    );
  }
}
