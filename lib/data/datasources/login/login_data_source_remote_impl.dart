import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:target_sistemas_test/core/failures.dart';
import 'package:target_sistemas_test/data/datasources/login/login_data_source_remote.dart';
import 'package:target_sistemas_test/data/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:target_sistemas_test/environment.dart';

/*
  Como forma de fazer um "mock" do login, foi usado a API DummyJSON, uma API fake.
  Ela possibilita simular muitas coisas, uma delas e a autenticação.

  Essa autenticação é feita com uma simples requisição post no endpoint https://dummyjson.com/auth/login
  Tendo no body o username e senha, em um JSON:

        {
          username: 'username',
          password: 'password'
        }
  
  Para fazer teste no APP use a seguintes credencia:
        username: kminchelle,
        password: 0lelplR

        Ou

        username: atuny0,
        password: 9uQFF1Lh
*/

class LoginDataSourceRemoteImpl implements LoginDataSourceRemote {
  final http.Client client;

  LoginDataSourceRemoteImpl({required this.client});

  @override
  Future<UserModel> loginWithUserNameAndPassword(
      {required String userName, required String password}) async {
    http.Response response;

    try {
      response = await client.post(
          Uri.parse("${Environment.baseUrl}/auth/login"),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({"username": userName, "password": password}));
    } catch (e) {
      debugPrint(e.toString());
      throw LoginFailure();
    }

    if (response.statusCode == 200) {
      final json = jsonDecode(utf8.decode(response.bodyBytes));
      return UserModel.fromJson(json);
    } else if (response.statusCode == 400) {
      throw InvalidCredentialsFailure();
    } else {
      throw LoginFailure();
    }
  }
}
