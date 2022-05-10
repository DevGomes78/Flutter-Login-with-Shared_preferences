import 'dart:convert';
import 'package:flutter_logar_listar/constants/service_constants_api.dart';
import 'package:flutter_logar_listar/models/user_models.dart';
import 'package:http/http.dart' as http;

List<UserModel> lista = [];

class UserController {
  Future<List<UserModel>?> GetUser({String? query}) async {
    try {
      var url = Uri.parse(ServiceUrl.BaseUrl);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        result.forEach((item) => lista.add(UserModel.fromJson(item)));
        if (query!.length > 1) {
          lista = lista
              .where((item) => item.name!.toLowerCase().contains(
                    query.toLowerCase(),
                  ))
              .toList();
        }
        return lista;
      }
    } catch (e) {
      print('Erro ao acessar a Pagina: $e');
      return [];
    }
    return [];
  }
}
