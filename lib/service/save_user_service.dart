import 'dart:convert';
import 'package:flutter_logar_listar/views/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/string_constants_login.dart';
import '../models/user_service_models.dart';
import 'package:flutter/material.dart';

class SaveUser {
  saveUser(UserModel userModel, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
      StringConstants.loguinUserInfos,
      json.encode(userModel.toJson()),
    );
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
