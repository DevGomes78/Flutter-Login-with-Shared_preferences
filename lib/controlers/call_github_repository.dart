
import 'package:flutter/cupertino.dart';
import 'package:flutter_logar_listar/models/user_api_models.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class GitHubRepository extends StatelessWidget {
  UserApiModel userApiModel;
  GitHubRepository({Key? key, required this.userApiModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void callGithub() async {
    if (await launch(userApiModel.htmlUrl.toString())) {
      await launch(
        userApiModel.htmlUrl.toString(),
        enableJavaScript: true,
        forceWebView: true,
      );
    } else {
      throw 'Could not launch $userApiModel.htmlUrl.toString()';
    }
  }
}