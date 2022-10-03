import 'package:flutter/material.dart';
import 'package:flutter_logar_listar/constants/string_constants_login.dart';
import 'package:flutter_logar_listar/service/user_api_service.dart';
import 'package:flutter_logar_listar/models/user_api_models.dart';

import '../controlers/call_github_repository.dart';

class SearchUser extends SearchDelegate {
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
    return FutureBuilder<List<UserApiModel>>(
        future: UserController().searchApiUser(query: query),
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
                      onTap: GitHubRepository(userApiModel: lista[index]).callGithub,
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
        StringConstants.buscarUsuario,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
      ),
    );
  }
}
