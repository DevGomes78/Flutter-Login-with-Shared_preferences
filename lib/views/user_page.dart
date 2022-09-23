import 'package:flutter/material.dart';
import 'package:flutter_logar_listar/utils/call_github_repository.dart';
import 'package:flutter_logar_listar/controlers/search_controller.dart';
import 'package:flutter_logar_listar/controlers/user_controller.dart';
import 'package:flutter_logar_listar/models/user_api_models.dart';
import 'package:flutter_logar_listar/views/shimmer_page.dart';

import '../components/drawer_widget.dart';

class UserPage extends StatefulWidget {
  String? name;
  String? email;

  UserPage({this.name, this.email});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool isLoading = false;
  List<UserApiModel> lista = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      loadUser();
    });
  }

  Future loadUser() async {
    setState(() => isLoading = true);
    await Future.delayed(
      const Duration(seconds: 2),
    );
    UserController().GetUser(query: '').then((map) {
      setState(() {
        lista = map!;
      });
    });
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      drawer: DrawerWidget(
        name: widget.name.toString(),
        email: widget.email.toString(),
      ),
      body: RefreshIndicator(
        onRefresh: UserController().GetUser,
        child: ListView.builder(
            itemCount: isLoading ? 10 : lista.length,
            itemBuilder: (context, index) {
              if (isLoading) {
                return const Skeleton().buildListTile();
              } else {
                return _listUser(index);
              }
            }),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.deepPurple,
      title: Text(widget.name.toString()),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            showSearch(context: context, delegate: BuscaUsuario());
          },
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }

  _listUser(int index) {
    return Card(
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
            lista[index].owner!.avatarUrl.toString(),
          ),
        ),
        title: Text(lista[index].name.toString()),
        subtitle: Text(lista[index].htmlUrl.toString()),
        onTap: GitHubReposiatory(userApiModel: lista[index]).callGithub,
      ),
    );
  }
}
