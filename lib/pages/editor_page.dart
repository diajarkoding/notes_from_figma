import 'package:flutter/material.dart';
import 'package:notes_from_figma/dbhelper/db_helper.dart';
import 'package:notes_from_figma/models/note_model.dart';
import 'package:notes_from_figma/pages/home_page_2.dart';

import 'package:notes_from_figma/theme/theme.dart';

class EditorPage extends StatefulWidget {
  final NoteModel? oldNote;

  const EditorPage({Key? key, this.oldNote}) : super(key: key);

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  late DbHelper dbHelper;
  var updateMode = false;
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
    if (widget.oldNote != null) {
      setUpdateMode(widget.oldNote);
    }
  }

  setUpdateMode(oldNote) {
    updateMode = true;
    titleController.text = widget.oldNote!.title.toString();
    bodyController.text = widget.oldNote!.body.toString();
  }

  submitNote(context) async {
    if (updateMode == true) {
      final newNote = NoteModel(
          id: widget.oldNote!.id,
          title: titleController.text,
          body: bodyController.text);

      await dbHelper.updateNote(newNote).then(
        (value) {
          print('berhasil');
          print(titleController.text);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePageTwo(),
            ),
          );
        },
      );
    } else {
      final newNote =
          NoteModel(title: titleController.text, body: bodyController.text);

      await dbHelper.saveNote(newNote).then(
        (value) {
          print('berhasil');
          print(titleController.text);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePageTwo(),
            ),
          );
        },
      );
    }
  }

  removeNote(noteId) async {
    await dbHelper.deleteNote(noteId).then(
      (value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePageTwo(),
          ),
        );
      },
    );
  }

  Widget appBarNote(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: kGreyColor,
              ),
              child: Icon(
                Icons.arrow_back_ios_rounded,
                color: kWhiteColor,
              ),
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () => removeNote(widget.oldNote!.id),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: kGreyColor,
                  ),
                  child: Icon(
                    Icons.delete_outline,
                    color: kWhiteColor,
                  ),
                ),
              ),
              const SizedBox(
                width: 21,
              ),
              GestureDetector(
                onTap: () {
                  // submitNote(context);
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: const Color(0xff252525),
                          title: const Icon(
                            Icons.info,
                            color: Color(0xff606060),
                          ),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Save changes ?',
                                style: whiteTextStyle.copyWith(
                                    fontSize: 20, fontWeight: light),
                              ),
                            ],
                          ),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: const Color(0xffFF0000)),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Discard',
                                      style: whiteTextStyle.copyWith(
                                          fontSize: 15, fontWeight: regular),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: const Color(0xff30BE71)),
                                    onPressed: () {
                                      submitNote(context);
                                    },
                                    child: Text(
                                      updateMode ? 'Update' : 'Save',
                                      style: whiteTextStyle.copyWith(
                                          fontSize: 15, fontWeight: regular),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        );
                      });
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: kGreyColor,
                  ),
                  child: Icon(
                    Icons.save_outlined,
                    color: kWhiteColor,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget bodyNote(BuildContext context) {
    return Column(
      children: [
        TextField(
          style: grayTextStyle.copyWith(
            fontSize: 35,
            fontWeight: light,
          ),
          controller: titleController,
          decoration: InputDecoration.collapsed(
            hintText: 'Judul',
            hintStyle: grayTextStyle.copyWith(
              fontSize: 35,
              fontWeight: light,
            ),
          ),
        ),
        TextField(
          style: grayTextStyle.copyWith(
            fontSize: 20,
            fontWeight: light,
          ),
          controller: bodyController,
          keyboardType: TextInputType.multiline,
          maxLines: 10,
          decoration: InputDecoration.collapsed(
            hintText: 'Tulis sesuatu ....',
            hintStyle: grayTextStyle.copyWith(
              fontSize: 20,
              fontWeight: light,
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkGreyColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ListView(
            children: [appBarNote(context), bodyNote(context)],
          ),
        ),
      ),
    );
  }
}
