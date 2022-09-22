import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_logar_listar/components/button_widget.dart';
import 'package:flutter_logar_listar/components/container_widget.dart';
import 'package:flutter_logar_listar/components/text_formWidget.dart';
import 'package:flutter_logar_listar/components/text_widget.dart';
import 'package:flutter_logar_listar/constants/string_constants_login.dart';
import 'package:flutter_logar_listar/controlers/login_controller.dart';
import 'package:flutter_logar_listar/models/user_models.dart';
import 'package:flutter_logar_listar/utils/validar_campos.dart';
import 'package:flutter_logar_listar/views/register_page.dart';
import 'package:flutter_logar_listar/views/user_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/error_constants.dart';
import '../constants/service_constants_api.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController senhaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ContainerWidget(text: 'Login'),
              const SizedBox(height: 200),
              _mountAreaEmail(),
              const SizedBox(height: 10),
              _mountAreaLogin(),
              Container(
                margin: const EdgeInsets.only(top: 10, right: 20),
                alignment: Alignment.centerRight,
                child: InkWell(
                  child: const Text(
                    StringConstants.esqueceuSenha,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.deepPurple),
                  ),
                  onTap: () {},
                ),
              ),
              const SizedBox(height: 50),
              InkWell(
                onTap: () {
                  _doLogin();
                },
                child: ButtonWidget(
                  text: 'Login',
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterPage()));
                },
                child: Textwidget(
                  cadastro: StringConstants.cadastrar,
                  login: StringConstants.naoTemCadastro,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _mountAreaLogin() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.grey[200],
        ),
        child: TextFormWidget(
          StringConstants.login,
          StringConstants.digiteLogin,
          const Icon(
            Icons.vpn_key,
            color: Colors.deepPurple,
          ),
          sulfixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
            ),
          ),
          controller: senhaController,
          obscureText: _obscureText,
          validator: Validate().validateSenha,
        ),
      ),
    );
  }

  _mountAreaEmail() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.grey[200],
        ),
        child: TextFormWidget(
          StringConstants.email,
          StringConstants.digiteEmail,
          const Icon(
            Icons.email,
            color: Colors.deepPurple,
          ),
          controller: emailController,
          obscureText: false,
          validator: Validate().validateEmail,
        ),
      ),
    );
  }

  _doLogin() async {
    if (_formKey.currentState!.validate()) {
      String mailForm = emailController.text;
      String senhaForm = senhaController.text;
      UserModel savedUser = await _getsavedUser();

      if(mailForm == savedUser.mail&& senhaForm == savedUser.senha){
        Navigator.push(context,
            MaterialPageRoute(builder: (context)=>UserPage()));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
            content: Text(ErrorConstants.ApiErrorLogin),
          ),
        );
      }
    }
  }

  Future<UserModel> _getsavedUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonUser = prefs.getString(StringConstants.loguinUserInfos);
    Map<String,dynamic> mapUser = json.decode(jsonUser.toString());
    UserModel userModel = UserModel.fromJson(mapUser);
    return userModel;

  }
}
