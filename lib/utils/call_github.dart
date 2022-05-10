
import 'package:flutter/cupertino.dart';
import 'package:flutter_logar_listar/models/user_models.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class GitHub extends StatelessWidget {
  UserModel userModel;
  GitHub({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void callGithub() async {
    if (await launch(userModel.htmlUrl.toString())) {
      await launch(
        userModel.htmlUrl.toString(),
        enableJavaScript: true,
        forceWebView: true,
      );
    } else {
      throw 'Could not launch $userModel.htmlUrl.toString()';
    }
  }
}