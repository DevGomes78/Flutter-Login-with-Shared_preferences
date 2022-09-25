import 'package:flutter/material.dart';
import 'package:flutter_logar_listar/components/button_widget.dart';
import 'package:flutter_logar_listar/components/container_widget.dart';
import 'package:flutter_logar_listar/components/text_formWidget.dart';
import 'package:flutter_logar_listar/components/text_widget.dart';
import 'package:flutter_logar_listar/constants/string_constants_login.dart';
import 'package:flutter_logar_listar/models/user_service_models.dart';
import 'package:flutter_logar_listar/utils/validar_campos.dart';
import 'package:flutter_logar_listar/views/register_page.dart';
import 'package:flutter_logar_listar/views/user_page.dart';
import '../constants/error_constants.dart';
import '../service/login_service.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController senhaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _obscureText = true;
  bool saved = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!saved) {
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                ContainerWidget(text: StringConstants.login),
                const SizedBox(height: 200),
                _AreaEmail(),
                const SizedBox(height: 10),
                _AreaLogin(),
                _textEsqueceuSenha(),
                const SizedBox(height: 50),
                _btnLogin(),
                const SizedBox(height: 10),
                _textCadastrarLogin(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _textCadastrarLogin(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RegisterPage()));
      },
      child: Textwidget(
        cadastro: StringConstants.cadastrar,
        login: StringConstants.naoTemCadastro,
      ),
    );
  }

  _btnLogin() {
    return InkWell(
      onTap: () {
        _doLogin();
      },
      child: ButtonWidget(
        text: StringConstants.login,
      ),
    );
  }

  Container _textEsqueceuSenha() {
    return Container(
      margin: const EdgeInsets.only(top: 10, right: 20),
      alignment: Alignment.centerRight,
      child: InkWell(
        child: const Text(
          StringConstants.esqueceuSenha,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
        onTap: () {},
      ),
    );
  }

  _AreaLogin() {
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
          StringConstants.digiteSenha,
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

  _AreaEmail() {
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
      UserModel savedUser = await LoginUser().getsavedUser();

      if (mailForm == savedUser.mail && senhaForm == savedUser.senha) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UserPage(
                      name: savedUser.name,
                      email: savedUser.mail,
                    )));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(ErrorConstants.ApiErrorLogin),
          ),
        );
      }
    }
  }
}
