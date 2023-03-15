import 'package:flutter/material.dart';

class Flashcard extends StatelessWidget {
  const Flashcard({
    Key? key,
    required this.book,
    required this.chapter,
    required this.verse,
    required this.verseText,
  }) : super(key: key);

  final String book;
  final String chapter;
  final String verse;
  final String verseText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 3.0,
            // style:
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$book $chapter:$verse',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
            Text(
              verseText,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
