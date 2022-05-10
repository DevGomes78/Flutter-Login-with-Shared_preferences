import 'package:flutter/material.dart';
import 'package:flutter_logar_listar/controlers/user_controller.dart';
import 'package:flutter_logar_listar/models/user_models.dart';

import '../utils/call_github.dart';

class BuscaUsuario extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<UserModel>?>(
        future: UserController().GetUser(query: query),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          snapshot.data![index].owner!.avatarUrl.toString(),
                        ),
                      ),
                      title: Text(
                        snapshot.data![index].name.toString(),
                      ),
                      subtitle: Text(
                        snapshot.data![index].htmlUrl.toString(),
                      ),
                      onTap: GitHub(userModel: lista[index]).callGithub,
                    ),
                  );
                });
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
      child: Text(
        'Buscar Usuario',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
      ),
    );
  }
}
