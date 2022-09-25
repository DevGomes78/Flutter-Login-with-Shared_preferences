import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/string_constants_login.dart';
import '../models/user_service_models.dart';

class LoginUser {
  Future<UserModel> getsavedUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonUser = prefs.getString(StringConstants.loguinUserInfos);
    Map<String, dynamic> mapUser = json.decode(jsonUser.toString());
    UserModel userModel = UserModel.fromJson(mapUser);
    return userModel;
  }
}
