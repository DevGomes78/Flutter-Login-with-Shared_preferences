import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_logar_listar/constants/error_constants.dart';
import 'package:flutter_logar_listar/views/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/string_constants_login.dart';
import '../models/user_service_models.dart';

class LoginUser {
  Future<bool?> showConfirmationDialog(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Usuario nao cadastrado'),
            actions: [
              TextButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterPage())),
                child: const Text('Cadastrar login'),
              ),
            ],
          );
        });
  }

  Future<UserModel?> getsavedUser(context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? jsonUser = prefs.getString(StringConstants.loguinUserInfos);
      if (jsonUser == null) {
        showConfirmationDialog(context);
      }
      Map<String, dynamic> mapUser = json.decode(jsonUser.toString());
      UserModel userModel = UserModel.fromJson(mapUser);
      return userModel;
    } catch (e) {
      print('${ErrorConstants.userNotRegister}$e');
    }
    return null;
  }
}
