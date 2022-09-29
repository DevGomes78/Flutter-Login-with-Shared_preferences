import 'package:flutter/material.dart';
import 'package:flutter_logar_listar/views/login_page.dart';

import '../constants/string_constants_login.dart';

class DrawerWidget extends StatelessWidget {
  String name;
  String email;

  DrawerWidget({
    Key? key,
    required this.email,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: Text(email),
            accountName: Text(name),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                name[0].toUpperCase(),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text(StringConstants.minhaConta),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(color: Colors.grey),
          const ListTile(
            leading: Icon(Icons.settings),
            title: Text(StringConstants.configuracoes),
          ),
          const Divider(color: Colors.grey),
          ListTile(
            leading: const Icon(Icons.input_rounded),
            title: const Text(StringConstants.sair),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ));
            },
          ),
          const Divider(color: Colors.grey),
        ],
      ),
    );
  }
}
