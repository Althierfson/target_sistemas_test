import 'package:flutter/material.dart';
import 'package:target_sistemas_test/container_injection.dart';
import 'package:target_sistemas_test/route_generato.dart';
import 'package:target_sistemas_test/theme.dart';

/*
  O aplicativo utiliza a API DummyJSON, uma API fictícia que possibilita
  simular diversas funcionalidades, incluindo a autenticação.

  O processo de autenticação é realizado por meio de uma requisição
  POST simples no endpoint https://dummyjson.com/auth/login.

  Essa requisição deve ter um JSON no body no seguinte formato:

      {
          username: 'username',
          password: 'password'
      }

  Para fazer teste no APP use uma das seguintes credencias:

      username: kminchelle,
      password: 0lelplR

  Ou

      username: atuny0,
      password: 9uQFF1Lh

  Você pode encontrar outras credencias nesse link: https://dummyjson.com/users.
*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupContainer();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Target Sistemas Test',
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.theme,
      onGenerateRoute: it<RouteGenerato>().generateRoute,
      initialRoute: "/login",
    );
  }
}
