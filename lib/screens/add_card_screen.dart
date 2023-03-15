import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:memory_gym/constants.dart';
import 'package:memory_gym/components/flashcard.dart';
import 'package:memory_gym/data/database.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({Key? key}) : super(key: key);

  static const String id = 'add_card_screen';

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  String book = 'Genesis';
  String chapter = '1';
  String verse = '1';
  String verseText = 'In the beginning God created the heaven and the earth.';
  Flashcard card = Flashcard(
    book: 'Genesis',
    chapter: '1',
    verse: '1',
    verseText: 'In the beginning God created the heaven and the earth.',
  );
  Map<dynamic, dynamic> oldTestamentList = {};
  Map<dynamic, dynamic> newTestamentList = {};
  Map<dynamic, dynamic> bookOfMormonList = {};
  Map<dynamic, dynamic> doctrineAndCovenantsList = {};
  Map<dynamic, dynamic> pearlOfGreatPriceList = {};

  final _queuedCardsBox = Hive.box('queuedCardsBox');
  FlashcardDatabase db = FlashcardDatabase();

  @override
  void initState() {
    db.loadData();
    super.initState();
  }

  void saveFlashcardDataToDatabase() {
    setState(() {
      db.queuedFlashcards.add({
        'book': book,
        'chapter': chapter,
        'verse': verse,
        'verseText': verseText,
        'dayAdded': DateTime.now(),
      });
    });
    db.updateDatabase();
  }

  void setCard() {
    try {
      setState(() {
        // tbh idk if we need setState here
        if (oldTestamentList.containsKey(book)) {
          if (oldTestamentList[book].containsKey(chapter)) {
            if (oldTestamentList[book][chapter].containsKey(verse)) {
              verseText = oldTestamentList[book][chapter][verse];
            }
          }
        }
        if (newTestamentList.containsKey(book)) {
          if (newTestamentList[book].containsKey(chapter)) {
            if (newTestamentList[book][chapter].containsKey(verse)) {
              verseText = newTestamentList[book][chapter][verse];
            }
          }
        }
        if (bookOfMormonList.containsKey(book)) {
          if (bookOfMormonList[book].containsKey(chapter)) {
            if (bookOfMormonList[book][chapter].containsKey(verse)) {
              verseText = bookOfMormonList[book][chapter][verse];
            }
          }
        }
        if (doctrineAndCovenantsList.containsKey(book)) {
          if (doctrineAndCovenantsList[book].containsKey(chapter)) {
            if (doctrineAndCovenantsList[book][chapter].containsKey(verse)) {
              verseText = doctrineAndCovenantsList[book][chapter][verse];
            }
          }
        }
        if (pearlOfGreatPriceList.containsKey(book)) {
          if (pearlOfGreatPriceList[book].containsKey(chapter)) {
            if (pearlOfGreatPriceList[book][chapter].containsKey(verse)) {
              verseText = pearlOfGreatPriceList[book][chapter][verse];
            }
          }
        }
        card = Flashcard(
          book: book,
          chapter: chapter,
          verse: verse,
          verseText: verseText,
        );
      });
    } catch (e) {
      print('You did not read the JSON scripture files correctly at all.');
      print(e);
    }
  }

  Future<void> readScriptures() async {
    final String oldTestament =
        await rootBundle.loadString('assets/old-testament-reference.json');
    final oldTestamentData = await json.decode(oldTestament);
    final String newTestament =
        await rootBundle.loadString('assets/new-testament-reference.json');
    final newTestamentData = await json.decode(newTestament);
    final String bookOfMormon =
        await rootBundle.loadString('assets/book-of-mormon-reference.json');
    final bookOfMormonData = await json.decode(bookOfMormon);
    final String doctrineAndCovenants = await rootBundle
        .loadString('assets/doctrine-and-covenants-reference.json');
    final doctrineAndCovenantsData = await json.decode(doctrineAndCovenants);
    final String pearlOfGreatPrice = await rootBundle
        .loadString('assets/pearl-of-great-price-reference.json');
    final pearlOfGreatPriceData = await json.decode(pearlOfGreatPrice);
    setState(() {
      oldTestamentList = oldTestamentData;
      newTestamentList = newTestamentData;
      bookOfMormonList = bookOfMormonData;
      doctrineAndCovenantsList = doctrineAndCovenantsData;
      pearlOfGreatPriceList = pearlOfGreatPriceData;
    });
  }

  @override
  Widget build(BuildContext context) {
    readScriptures(); // I can't comment this out here and just use it in an overridden initState. I tried that to make it less laggy but it wouldn't change the new verse, this needs to be called because otherwise the bookList stuff is just blank
    setCard();
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  book = value;
                },
                decoration: kTextFileDecoration.copyWith(hintText: '$book'),
              ),
            ),
            Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) {
                        chapter = value;
                      },
                      decoration: kTextFileDecoration.copyWith(
                          hintText: 'Chapter $chapter'),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) {
                        verse = value;
                      },
                      decoration: kTextFileDecoration.copyWith(
                          hintText: 'Verse $verse'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: ListView(children: [card]),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    // tbh this setstate is kinda unnecessary cause the function has a setstate too
                    saveFlashcardDataToDatabase();
                  });
                },
                child: const Text('Add Card to Queue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
