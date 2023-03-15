import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:memory_gym/screens/current_deck_screen.dart';
import 'package:memory_gym/screens/practice_card_screen.dart';

import '../components/flashcard.dart';
import '../data/database.dart';
import 'add_card_screen.dart';

class QueuedCardsScreen extends StatefulWidget {
  const QueuedCardsScreen({Key? key}) : super(key: key);

  static const String id = 'queued_cards_screen';

  @override
  State<QueuedCardsScreen> createState() => _QueuedCardsScreenState();
}

class _QueuedCardsScreenState extends State<QueuedCardsScreen> {
  final _queuedCardsBox = Hive.box('queuedCardsBox');
  FlashcardDatabase db = FlashcardDatabase();

  @override
  void initState() {
    db.loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Queued Cards'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: db.queuedFlashcards.length,
                itemBuilder: (context, index) {
                  return TextButton(
                    onPressed: () {},
                    onLongPress: () async {
                      switch (await showDialog<String>(
                          context: context,
                          builder: (BuildContext context) {
                            return SimpleDialog(
                              title: const Text('Select assignment'),
                              children: <Widget>[
                                SimpleDialogOption(
                                  onPressed: () {
                                    Navigator.pop(context, 'Delete Card');
                                  },
                                  child: const Text('Delete Card'),
                                ),
                                SimpleDialogOption(
                                  onPressed: () {
                                    Navigator.pop(
                                        context, 'Add Card To Current Deck');
                                  },
                                  child: const Text('Add Card To Current Deck'),
                                ),
                                SimpleDialogOption(
                                  onPressed: () {
                                    Navigator.pop(
                                        context, 'Don\'t Delete Card');
                                  },
                                  child: const Text('Don\'t Delete Card'),
                                ),
                              ],
                            );
                          })) {
                        case 'Delete Card':
                          setState(() {
                            db.queuedFlashcards.removeAt(index);
                            db.updateDatabase();
                          });
                          break;
                        case 'Add Card To Current Deck':
                          setState(() {
                            db.loadData();
                            db.inProgressFlashcards
                                .add(db.queuedFlashcards[index]);
                            db.queuedFlashcards.removeAt(index);
                            db.updateDatabase();
                          });
                          break;
                        case 'Don\'t Delete Card':
                          break;
                        case null:
                          // dialog dismissed
                          break;
                      }
                    },
                    child: Flashcard(
                      book: db.queuedFlashcards[index]['book'],
                      chapter: db.queuedFlashcards[index]['chapter'],
                      verse: db.queuedFlashcards[index]['verse'],
                      verseText: db.queuedFlashcards[index]['verseText'],
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
                    Navigator.popAndPushNamed(context, AddCardScreen.id);
                  },
                  child: const Text('Add a Card to the Queue'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
