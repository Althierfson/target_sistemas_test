import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:target_sistemas_test/container_injection.dart';
import 'package:target_sistemas_test/custom_colors.dart';
import 'package:target_sistemas_test/presentation/mobx/notes/notes_store.dart';
import 'package:target_sistemas_test/presentation/widgets/note_tile.dart';

class EditNotePage extends StatefulWidget {
  const EditNotePage({super.key});

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  late NotesStore _store;
  late List<ReactionDisposer> _disposers;

  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    _store = it<NotesStore>();
    _store.fetchNotesList();
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
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [CustomColors.cello, CustomColors.lochinvar])),
        child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: constraints.maxWidth,
                  minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    const Spacer(),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 200,
                        color: Colors.white,
                        child: SingleChildScrollView(
                          child: Observer(builder: (context) {
                            return Column(
                              children: List.generate(
                                  _store.notes.length,
                                  (index) => NoteTile(
                                        text: _store.notes[index],
                                        onEditTap: () {
                                          FocusScope.of(context)
                                              .requestFocus(_focusNode);

                                          _store.noteSelected = index;
                                          _textEditingController.text =
                                              _store.notes[index];
                                        },
                                        onDeleteTap: () {
                                          FocusScope.of(context)
                                              .requestFocus(_focusNode);

                                          _store.removeNote(index);
                                        },
                                      )),
                            );
                          }),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 80.0, top: 30.0, right: 80.0),
                      child: TextField(
                        controller: _textEditingController,
                        autofocus: true,
                        focusNode: _focusNode,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            filled: true,
                            hintText: "Digite seu texto",
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.all(0)),
                        onSubmitted: (value) {
                          FocusScope.of(context).requestFocus(_focusNode);

                          _store.updateNotes(value);
                          _textEditingController.text = "";
                        },
                      ),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
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
          );
        }),
      ),
    );
  }
}
