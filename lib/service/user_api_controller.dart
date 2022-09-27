import 'dart:convert';
import 'package:flutter_logar_listar/constants/error_constants.dart';
import 'package:flutter_logar_listar/constants/service_constants_api.dart';
import 'package:flutter_logar_listar/models/user_api_models.dart';
import 'package:http/http.dart' as http;



class UserController {
  List<UserApiModel> lista = [];
  Future<List<UserApiModel>> SearchApiUser({required String query}) async {
    try {
      var url = Uri.parse(ServiceApiUrl.baseUrl);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        result.forEach((item) => lista.add(UserApiModel.fromJson(item)));
        if (query.length > 1) {
          lista = lista
              .where((item) => item.name!.toLowerCase().contains(
                    query.toLowerCase(),
                  ))
              .toList();
        }
        return lista;
      }
    } catch (e) {
      print('${ErrorConstants.ApiErrorLogin}  $e');
      return [];
    }
    return [];
  }

  Future<List<UserApiModel>> GetUser() async {
    try {
      var url = Uri.parse(ServiceApiUrl.baseUrl);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        result.forEach((item) => lista.add(UserApiModel.fromJson(item)));
        return lista;
      }
    } catch (e) {
      print('${ErrorConstants.ApiErrorLogin}  $e');
      return [];
    }
    return [];
  }
}
