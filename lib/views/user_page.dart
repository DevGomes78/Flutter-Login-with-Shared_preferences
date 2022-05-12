import 'package:flutter/material.dart';
import 'package:flutter_logar_listar/utils/call_github_repository.dart';
import 'package:flutter_logar_listar/controlers/login_controller.dart';
import 'package:flutter_logar_listar/controlers/search.dart';
import 'package:flutter_logar_listar/controlers/user_controller.dart';
import 'package:flutter_logar_listar/models/user_models.dart';
import 'package:flutter_logar_listar/views/shimmer_page.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool isLoading = false;
  List<UserModel> lista = [];

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
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Lista de Usuarios'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: BuscaUsuario());
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: UserController().GetUser,
        child: ListView.builder(
            itemCount: isLoading ? 10 : lista.length,
            itemBuilder: (context, index) {
              if (isLoading) {
                return const Skeleton().buildListTile();
              } else {
                return buildCard(index);
              }
            }),
      ),
    );
  }

  Card buildCard(int index) {
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
        onTap: GitHubReposiatory(userModel: lista[index]).callGithub,
      ),
    );
  }
}
