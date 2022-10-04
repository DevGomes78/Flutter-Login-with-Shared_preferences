import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_logar_listar/constants/error_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/string_constants_login.dart';
import '../models/user_service_models.dart';

class LoginUser {
  Future<UserModel?> getsavedUser(context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? jsonUser = prefs.getString(StringConstants.loguinUserInfos);
      if (jsonUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(ErrorConstants.userNotRegister),
          ),
        );
      }
      Map<String, dynamic> mapUser = json.decode(jsonUser.toString());
      UserModel userModel = UserModel.fromJson(mapUser);
      return userModel;
    }
    catch (e) {
      print('${ErrorConstants.userNotRegister}$e');
    }
    return null;
  }
}