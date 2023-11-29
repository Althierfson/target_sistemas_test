import 'package:flutter/material.dart';

class LoginTextFild extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<String>? inputErrors;
  final Function(String) onChange;

  const LoginTextFild(
      {super.key,
      required this.title,
      required this.icon,
      this.inputErrors,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        TextField(
          style: const TextStyle(fontSize: 14.0),
          decoration: InputDecoration(
            error: inputErrors != null
                ? Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                          inputErrors!.length,
                          (index) => Text(
                                "\u2022 ${inputErrors![index]}",
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 12),
                              )),
                    ),
                  )
                : null,
            contentPadding: const EdgeInsets.all(5.0),
            prefixIcon: Icon(
              icon,
              color: inputErrors == null || inputErrors!.isEmpty
                  ? Colors.black
                  : Colors.red,
              size: 18,
            ),
            fillColor: Colors.white,
            filled: true,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          ),
          onChanged: onChange,
        )
      ],
    );
  }
}
