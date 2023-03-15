import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:memory_gym/screens/practice_screens/card_first_view.dart';

import 'package:memory_gym/screens/queued_cards_screen.dart';
import 'package:memory_gym/screens/practice_card_screen.dart';

import '../components/flashcard.dart';
import '../data/database.dart';

class CurrentDeckScreen extends StatefulWidget {
  const CurrentDeckScreen({Key? key}) : super(key: key);

  static const String id = 'current_deck_screen';

  @override
  State<CurrentDeckScreen> createState() => _CurrentDeckScreenState();
}

class _CurrentDeckScreenState extends State<CurrentDeckScreen> {
  final _inProgressCardsBox = Hive.box('inProgressCardsBox');
  final _queuedCardsBox = Hive.box('queuedCardsBox');
  FlashcardDatabase db = FlashcardDatabase();

  @override
  void initState() {
    // db.loadData();
    // if (_inProgressCardsBox.get(db.inProgressKeyword) == null) {
    //   addToCurrentDeck();
    //   db.loadData(); // idk if this line is ok or nah tbh
    // }
    if (_inProgressCardsBox.get(db.inProgressKeyword) != null) {
      db.loadData();
    }
    super.initState();
  }

  void addToCurrentDeck() {
    db.loadData();
    db.inProgressFlashcards.add(db.queuedFlashcards[0]);
    db.queuedFlashcards.removeAt(0);
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Today\'s Cards'),
            const Expanded(child: SizedBox()),
            IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: Icon(Icons.refresh),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, QueuedCardsScreen.id);
              },
              icon: const Icon(Icons.playlist_add),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: db.inProgressFlashcards.length,
                itemBuilder: (context, index) {
                  return TextButton(
                    onPressed: () {},
                    onLongPress: () {
                      setState(() {
                        db.inProgressFlashcards.removeAt(index);
                        db.updateDatabase();
                      });
                    },
                    child: Flashcard(
                      book: db.inProgressFlashcards[index]['book'],
                      chapter: db.inProgressFlashcards[index]['chapter'],
                      verse: db.inProgressFlashcards[index]['verse'],
                      verseText: db.inProgressFlashcards[index]['verseText'],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (db.inProgressFlashcards.isNotEmpty) {
                      db.resetListIndex();
                      Navigator.pushNamed(
                          context, PracticeCardFirstViewScreen.id);
                    }
                  },
                  child: const Text('Practice Today\'s Cards'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
