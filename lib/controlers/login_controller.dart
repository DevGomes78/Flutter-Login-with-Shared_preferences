import 'package:flutter/material.dart';
import 'package:flutter_logar_listar/views/user_page.dart';
import 'package:http/http.dart' as http;

class LoginController {
  Future<void> login(context, String email, String password) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      final response =
          await http.post(Uri.parse('https://reqres.in/api/login'), body: {
        'email': email,
        'password': password,
      });
      if (response.statusCode == 200) {
       Navigator.push(context, MaterialPageRoute(builder: (context)=> UserPage()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('usuario ou senha invalidos'),
          ),
        );
      }
    }
  }
}
