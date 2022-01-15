import 'package:flutter/material.dart';
import 'package:notes_from_figma/dbhelper/db_helper.dart';
import 'package:notes_from_figma/models/note_model.dart';
import 'package:notes_from_figma/pages/editor_page.dart';
import 'package:notes_from_figma/pages/search_page.dart';
import 'package:notes_from_figma/theme/theme.dart';
import 'package:notes_from_figma/widgets/card_note_item.dart';
import 'extension_capitalize.dart';

class HomePageTwo extends StatefulWidget {
  const HomePageTwo({Key? key}) : super(key: key);

  @override
  State<HomePageTwo> createState() => _HomePageTwoState();
}

class _HomePageTwoState extends State<HomePageTwo> {
  late Future<List<NoteModel>> notes;
  late DbHelper dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
    loadNote();
  }

  loadNote() {
    setState(() {
      notes = dbHelper.getNotes();
    });
  }

  editNote(context, item) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditorPage(
                  oldNote: item,
                )));
  }

  Widget headerNote(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Notes',
            style: whiteTextStyle.copyWith(fontSize: 35, fontWeight: semiBold),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SearchPage()),
                  );
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: kGreyColor,
                  ),
                  child: Icon(
                    Icons.search,
                    color: kWhiteColor,
                  ),
                ),
              ),
              const SizedBox(
                width: 21,
              ),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: kGreyColor,
                ),
                child: Icon(
                  Icons.info_outline,
                  color: kWhiteColor,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget bodyNote() {
    return FutureBuilder<List<NoteModel>>(
        future: notes,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  'Create your first note !',
                  style:
                      whiteTextStyle.copyWith(fontSize: 20, fontWeight: light),
                ),
              );
            }

            List<NoteModel>? data = snapshot.data;

            return Container(
              margin: const EdgeInsets.only(top: 90),
              child: Column(
                children: data!
                    .map(
                      (item) => GestureDetector(
                        onTap: () => editNote(context, item),
                        child: CardNoteItem(
                          title: item.title.capitalize(),
                        ),
                      ),
                    )
                    .toList(),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error Fetching Notes !',
                style: whiteTextStyle.copyWith(fontSize: 20, fontWeight: light),
              ),
            );
          } else {
            print(snapshot.data);
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkGreyColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [headerNote(context), bodyNote()],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EditorPage(),
            ),
          );
        },
        backgroundColor: kDarkGreyColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
