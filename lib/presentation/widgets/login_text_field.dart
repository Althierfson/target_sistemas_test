import 'package:flutter/material.dart';

class LoginTextFild extends StatefulWidget {
  final String title;
  final IconData icon;
  final List<String>? inputErrors;
  final Function(String) onChange;
  final bool? obscureText;

  const LoginTextFild(
      {super.key,
      required this.title,
      required this.icon,
      this.inputErrors,
      required this.onChange,
      this.obscureText});

  @override
  State<LoginTextFild> createState() => _LoginTextFildState();
}

class _LoginTextFildState extends State<LoginTextFild> {
  bool? obscureText;

  @override
  void initState() {
    obscureText = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            widget.title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        TextField(
          style: const TextStyle(fontSize: 14.0),
          obscureText: obscureText ?? false,
          decoration: InputDecoration(
              error: widget.inputErrors != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                            widget.inputErrors!.length,
                            (index) => Text(
                                  "\u2022 ${widget.inputErrors![index]}",
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 12),
                                )),
                      ),
                    )
                  : null,
              contentPadding: const EdgeInsets.all(5.0),
              prefixIcon: Icon(
                widget.icon,
                color: widget.inputErrors == null || widget.inputErrors!.isEmpty
                    ? Colors.black
                    : Colors.red,
                size: 18,
              ),
              fillColor: Colors.white,
              filled: true,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              suffixIcon: widget.obscureText != null
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText!;
                        });
                      },
                      icon: obscureText!
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    )
                  : null),
          onChanged: widget.onChange,
        )
      ],
    );
  }
}
