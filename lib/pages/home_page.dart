import 'package:flutter/material.dart';
import 'package:notes_from_figma/pages/home_page_2.dart';
import 'package:notes_from_figma/theme/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Widget appBarNote() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Notes',
          style: whiteTextStyle.copyWith(fontSize: 43, fontWeight: semiBold),
        ),
        Row(
          children: [
            Container(
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
    );
  }

  Widget bodyNote() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://thumbs.dreamstime.com/b/note-linear-icon-modern-outline-logo-concept-white-back-background-user-interface-web-navigation-collection-suitable-133526830.jpg'))),
          ),
          const SizedBox(
            height: 6.5,
          ),
          Text(
            'Create your first note !',
            style: whiteTextStyle.copyWith(fontSize: 20, fontWeight: light),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkGreyColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Stack(
            children: [appBarNote(), bodyNote()],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePageTwo(),
            ),
          );
        },
        backgroundColor: kDarkGreyColor,
        focusColor: const Color(0x00000000),
        hoverColor: const Color(0x00000000),
        child: const Icon(Icons.add),
      ),
    );
  }
}
