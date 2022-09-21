import 'package:flutter/material.dart';
import 'package:flutter_logar_listar/components/button_widget.dart';
import 'package:flutter_logar_listar/components/container_widget.dart';
import 'package:flutter_logar_listar/components/text_formWidget.dart';
import 'package:flutter_logar_listar/components/text_widget.dart';
import 'package:flutter_logar_listar/constants/string_constants_login.dart';
import 'package:flutter_logar_listar/controlers/login_controller.dart';
import 'package:flutter_logar_listar/utils/validar_campos.dart';
import 'package:flutter_logar_listar/views/login_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nomeController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _senhaController = TextEditingController();

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
              cardCadastrar(context),
              const SizedBox(height: 150),
              _campoNome(),
              const SizedBox(height: 10),
              _campoEmail(),
              const SizedBox(height: 10),
              _campoLogin(),
              textEsqueceuSenha(),
              const SizedBox(height: 50),
              InkWell(
                onTap: () {
                  _doLogin(context);
                },
                child: ButtonWidget(
                  text: StringConstants.cadastrar,
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Textwidget(
                  login: StringConstants.fazerLogin,
                  cadastro: StringConstants.jaecadastrado,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container textEsqueceuSenha() {
    return Container(
      margin: const EdgeInsets.only(top: 10, right: 20),
      alignment: Alignment.centerRight,
      child: InkWell(
        child: const Text(
          StringConstants.esqueceuSenha,
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple),
        ),
        onTap: () {},
      ),
    );
  }

  Stack cardCadastrar(BuildContext context) {
    return Stack(
      children: [
        ContainerWidget(text: StringConstants.cadastrar),
        Positioned(
          left: 8,
          bottom: 70,
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        )
      ],
    );
  }

  _campoNome() {
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
          StringConstants.nome,
          StringConstants.digiteNome,
          const Icon(
            Icons.person_add,
            color: Colors.deepPurple,
          ),
          controller: _nomeController,
          obscureText: _obscureText,
          validator: Validate().validateNome,
        ),
      ),
    );
  }

  _campoLogin() {
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
          controller: _senhaController,
          obscureText: _obscureText,
          validator: Validate().validateSenha,
        ),
      ),
    );
  }

  _campoEmail() {
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
          controller: _emailController,
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
        _emailController.text,
        _senhaController.text,
      );
    }
  }
}
