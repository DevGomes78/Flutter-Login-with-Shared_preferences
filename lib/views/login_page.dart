import 'package:flutter/material.dart';
import 'package:flutter_logar_listar/components/button_widget.dart';
import 'package:flutter_logar_listar/components/container_widget.dart';
import 'package:flutter_logar_listar/components/text_formWidget.dart';
import 'package:flutter_logar_listar/components/text_widget.dart';
import 'package:flutter_logar_listar/constants/service_constants_login.dart';
import 'package:flutter_logar_listar/controlers/login_controller.dart';
import 'package:flutter_logar_listar/utils/validar_campos.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController =
      TextEditingController(text: 'eve.holt@reqres.in');

  TextEditingController senhaController =
      TextEditingController(text: 'cityslicka');

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
                    ServiceLogin.MountForgoLogin,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.deepPurple),
                  ),
                  onTap: () {},
                ),
              ),
              const SizedBox(height: 50),
              InkWell(
                onTap: () {
                  _doLogin(context);
                },
                child: ButtonWidget(
                  text: 'Login',
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {},
                child: Textwidget(
                  cadastro: ServiceLogin.MountAreaNotRegister,
                  login: ServiceLogin.MountAreaRegister,
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
          ServiceLogin.MountAreaLogin,
          ServiceLogin.MountAreaDigiteLogin,
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
          ServiceLogin.MountAreaEmail,
          ServiceLogin.MountAreaDigiteEmail,
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

  _doLogin(context) async {
    if (_formKey.currentState!.validate()) {
      LoginController().login(
        context,
        emailController.text,
        senhaController.text,
      );
    }
  }
}
