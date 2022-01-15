import 'package:flutter/material.dart';
import 'package:notes_from_figma/theme/theme.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkGreyColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 37),
        child: SafeArea(
            child: ListView(
          children: [
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: kGreyColor,
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          style: whiteTextStyle.copyWith(
                            fontSize: 20,
                            fontWeight: light,
                          ),
                          decoration: InputDecoration.collapsed(
                            hintText: 'Food Recipe',
                            hintStyle: whiteTextStyle.copyWith(
                              fontSize: 20,
                              fontWeight: light,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close,
                          color: kWhiteColor,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
