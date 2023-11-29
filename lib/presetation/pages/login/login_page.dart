import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:target_sistemas_test/container_injection.dart';
import 'package:target_sistemas_test/custom_colors.dart';
import 'package:target_sistemas_test/presetation/mobx/login/login_mobx.dart';
import 'package:target_sistemas_test/presetation/widgets/login_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginStore _store;
  late List<ReactionDisposer> _disposers;

  String _userName = "";
  String _password = "";

  @override
  void initState() {
    _store = it<LoginStore>();
    _createReactionList();
    super.initState();
  }

  @override
  void dispose() {
    _disposers.map((e) => e());
    super.dispose();
  }

  _createReactionList() {
    _disposers = [
      reaction((_) => _store.error, (String? error) {
        if (error != null) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error)));
        }
        _store.error = null;
      }),
      reaction((_) => _store.goToNextpage, (bool go) {
        if (go) {
          Navigator.pushNamedAndRemoveUntil(
              context, "/edit-note", (route) => false);
        }
        _store.goToNextpage = false;
      })
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(32.0),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [CustomColors.cello, CustomColors.lochinvar])),
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: constraints.maxWidth,
                  minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Observer(builder: (_) {
                      return LoginTextFild(
                          title: "Usuário",
                          icon: Icons.person_rounded,
                          inputErrors: _store.userNameErrors,
                          onChange: (value) {
                            _userName = value;
                          });
                    }),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Observer(builder: (_) {
                      return LoginTextFild(
                          title: "Senha",
                          icon: Icons.lock,
                          inputErrors: _store.passwordErrors,
                          onChange: (value) {
                            _password = value;
                          });
                    }),
                    const SizedBox(
                      height: 40.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (!_store.isLoading) {
                          _store.makeLogin(
                              userName: _userName, password: _password);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColors.mediumSeaGreen,
                          padding:
                              const EdgeInsets.only(left: 60.0, right: 60.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0))),
                      child: Observer(builder: (_) {
                        if (_store.isLoading) {
                          return const CircularProgressIndicator(
                            color: Colors.white,
                          );
                        } else {
                          return const Text(
                            "Entrar",
                            style: TextStyle(color: Colors.white),
                          );
                        }
                      }),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/privacy-policy");
                      },
                      child: const Text(
                        "Política de Privacidade",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
