import 'package:flutter/material.dart';

class NoteTile extends StatelessWidget {
  final String text;
  final Function()? onEditTap;
  final Function()? onDeleteTap;
  const NoteTile(
      {super.key, required this.text, this.onEditTap, this.onDeleteTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Colors.black.withOpacity(.3)))),
        child: Row(children: [
          Expanded(
              child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          )),
          IconButton(
              onPressed: onEditTap,
              icon: const Icon(
                Icons.border_color_rounded,
                color: Colors.black,
              )),
          IconButton(
              onPressed: onDeleteTap,
              icon: const Icon(
                Icons.cancel,
                color: Colors.red,
              ))
        ]),
      ),
    );
  }
}
