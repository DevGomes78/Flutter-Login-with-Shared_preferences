import 'package:flutter/material.dart';
import 'package:flutter_logar_listar/components/button_widget.dart';
import 'package:flutter_logar_listar/components/container_widget.dart';
import 'package:flutter_logar_listar/components/text_formWidget.dart';
import 'package:flutter_logar_listar/components/text_widget.dart';
import 'package:flutter_logar_listar/constants/string_constants_login.dart';
import 'package:flutter_logar_listar/service/save_user_service.dart';
import 'package:flutter_logar_listar/controlers/validate_fields.dart';
import 'package:flutter_logar_listar/views/login_page.dart';
import '../models/user_service_models.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _obscureText = true;
  bool saved = false;

  Future<bool?> showConfirmationDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(StringConstants.desejaSair),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text(StringConstants.cancelar),
              ),
              OutlinedButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text(StringConstants.sair),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!saved) {
          final confirmation = await showConfirmationDialog();
          return confirmation ?? false;
        }
        return true;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                ContainerWidget(text: StringConstants.cadastrar),
                const SizedBox(height: 50),
                _nameField(),
                const SizedBox(height: 10),
                _lastnameField(),
                const SizedBox(height: 10),
                _emailField(),
                const SizedBox(height: 10),
                _passwordField(),
                const SizedBox(height: 10),
                _confirmPasswordField(),
                _textForgotPassword(),
                const SizedBox(height: 20),
                _btnRegisterLogin(),
                const SizedBox(height: 10),
                _textLogin(context),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _nameField() {
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
          controller: _nameController,
          obscureText: false,
          validator: Validate().validateName,
        ),
      ),
    );
  }

  _lastnameField() {
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
          StringConstants.sobreNome,
          StringConstants.digiteSobreNome,
          const Icon(
            Icons.person_add,
            color: Colors.deepPurple,
          ),
          controller: _lastNameController,
          obscureText: false,
          validator: Validate().validateLastName,
        ),
      ),
    );
  }

  _emailField() {
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

  _passwordField() {
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
          StringConstants.senha,
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
          controller: _passwordController,
          obscureText: _obscureText,
          validator: Validate().validatePassword,
        ),
      ),
    );
  }

  _confirmPasswordField() {
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
          StringConstants.repitaSenha,
          StringConstants.repitaSenha,
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
          controller: _repeatPasswordController,
          obscureText: _obscureText,
          validator: Validate().validateRepeatPassword,
        ),
      ),
    );
  }

  _btnRegisterLogin() {
    return InkWell(
      onTap: () {
        if (_passwordController.text == _repeatPasswordController.text) {
          _register();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(StringConstants.senhanaoconfere),
            ),
          );
        }
      },
      child: ButtonWidget(
        text: StringConstants.cadastrar,
      ),
    );
  }

  _textForgotPassword() {
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

  void _register() {
    if (_formKey.currentState!.validate()) {
      UserModel newUser = UserModel(
        name: _nameController.text,
        sobrenome: _lastNameController.text,
        mail: _emailController.text,
        senha: _passwordController.text,
        repitasenha: _repeatPasswordController.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(StringConstants.loginRegistrado),
        ),
      );
      SaveUser().saveUser(newUser);
      _nameController.clear();
      _lastNameController.clear();
      _emailController.clear();
      _passwordController.clear();
      _repeatPasswordController.clear();
    }
  }

  _textLogin(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Textwidget(
        cadastro: StringConstants.fazerLogin,
        login: StringConstants.jaecadastrado,
      ),
    );
  }
}
