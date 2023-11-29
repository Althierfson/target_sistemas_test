import 'package:flutter/material.dart';
import 'package:target_sistemas_test/container_injection.dart';
import 'package:target_sistemas_test/route_generato.dart';

/*
Para fazer teste no APP use uma das seguintes credencia:
  username: kminchelle,
  password: 0lelplR

  Ou

  username: atuny0,
  password: 9uQFF1Lh
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
      onGenerateRoute: it<RouteGenerato>().generateRoute,
      initialRoute: "/login",
    );
  }
}
