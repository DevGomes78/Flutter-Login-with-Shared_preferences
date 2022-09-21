import 'package:flutter/material.dart';
import 'package:flutter_logar_listar/constants/service_constants_api.dart';
import 'package:flutter_logar_listar/views/user_page.dart';
import 'package:http/http.dart' as http;

import '../constants/error_constants.dart';

class LoginController {
  Future<void> login(context, String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        final response = await http.post(Uri.parse(ServiceUrl.LoginUrl), body: {
          'email': email,
          'password': password,
        });
        if (response.statusCode == 200) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const UserPage()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(ServiceUrl.LoginUrl),
            ),
          );
        }
      }
    } catch (e) {
      print(ErrorConstants.ApiError);
      return;
    }
  }
}
