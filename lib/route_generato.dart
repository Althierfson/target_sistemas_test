import 'package:flutter/material.dart';
import 'package:target_sistemas_test/presentation/pages/core/privacy_policy_page.dart';
import 'package:target_sistemas_test/presentation/pages/login/login_page.dart';
import 'package:target_sistemas_test/presentation/pages/notes/edit_note_page.dart';

class RouteGenerato {
  Route<dynamic> generateRoute(RouteSettings settings) {
    return MaterialPageRoute(
        builder: (_) => _mapRouteName(settings.name, settings.arguments));
  }

  Widget _mapRouteName(String? name, Object? arguments) {
    switch (name) {
      case "/login":
        return const LoginPage();
      case "/edit-note":
        return const EditNotePage();
      case "/privacy-policy":
        return const PrivacyPolicyPage();
      default:
        return _errorPage();
    }
  }

  Widget _errorPage() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Error"),
      ),
      body: const Center(
        child: Text("Error"),
      ),
    );
  }
}
