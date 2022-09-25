import 'package:flutter/material.dart';
import 'package:flutter_logar_listar/components/button_widget.dart';
import 'package:flutter_logar_listar/components/container_widget.dart';
import 'package:flutter_logar_listar/components/text_formWidget.dart';
import 'package:flutter_logar_listar/components/text_widget.dart';
import 'package:flutter_logar_listar/constants/string_constants_login.dart';
import 'package:flutter_logar_listar/service/save_service.dart';
import 'package:flutter_logar_listar/utils/validar_campos.dart';
import 'package:flutter_logar_listar/views/login_page.dart';
import '../models/user_service_models.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _sobreNomeController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _repitaSenhaController = TextEditingController();

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
                const SizedBox(height: 100),
                _campoNome(),
                const SizedBox(height: 10),
                _campoSobreNome(),
                const SizedBox(height: 10),
                _campoEmail(),
                const SizedBox(height: 10),
                _campoSenha(),
                const SizedBox(height: 10),
                _campoRepitaSenha(),
                _textEsqueceuSenha(),
                const SizedBox(height: 50),
                _btnCadastrarLogin(),
                const SizedBox(height: 10),
                _textFazerLogin(context),
              ],
            ),
          ),
        ),
      ),
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
          obscureText: false,
          validator: Validate().validateNome,
        ),
      ),
    );
  }

  _campoSobreNome() {
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
          controller: _sobreNomeController,
          obscureText: false,
          validator: Validate().validateSobreNome,
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

  _campoSenha() {
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
          controller: _senhaController,
          obscureText: _obscureText,
          validator: Validate().validateSenha,
        ),
      ),
    );
  }

  _campoRepitaSenha() {
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
          controller: _repitaSenhaController,
          obscureText: _obscureText,
          validator: Validate().validateRepitaSenha,
        ),
      ),
    );
  }

  _btnCadastrarLogin() {
    return InkWell(
      onTap: () {
        if (_senhaController.text == _repitaSenhaController.text) {
          _register();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('senhas nao conferem'),
            ),
          );
        }
      },
      child: ButtonWidget(
        text: StringConstants.cadastrar,
      ),
    );
  }

  _textEsqueceuSenha() {
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
        name: _nomeController.text,
        sobrenome: _sobreNomeController.text,
        mail: _emailController.text,
        senha: _senhaController.text,
        repitasenha: _repitaSenhaController.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(StringConstants.loginRegistrado),
        ),
      );
      SaveUser().saveUser(newUser);
      _nomeController.clear();
      _sobreNomeController.clear();
      _emailController.clear();
      _senhaController.clear();
      _repitaSenhaController.clear();
    }
  }

  _textFazerLogin(BuildContext context) {
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
