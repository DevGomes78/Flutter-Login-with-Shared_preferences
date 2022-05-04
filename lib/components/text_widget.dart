import 'package:flutter/material.dart';


class Textwidget extends StatelessWidget {
  String? cadastro;
  String? login;

  Textwidget({
    Key? key,
    required this.cadastro,
    required this.login,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(cadastro!),
          Text(
            login!,
            style: const TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}