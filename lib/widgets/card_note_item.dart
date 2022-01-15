import 'package:flutter/material.dart';
import 'package:notes_from_figma/theme/theme.dart';

class CardNoteItem extends StatelessWidget {
  final String title;

  const CardNoteItem({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: kLightBlue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          title,
          style: blackTextStyle.copyWith(fontSize: 20, fontWeight: regular),
        ),
      ),
    );
  }
}
