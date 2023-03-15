import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:memory_gym/components/flashcard.dart';
import 'package:memory_gym/data/database.dart';
import 'package:memory_gym/screens/practice_screens/card_hidden_view.dart';

class PracticeCardFirstViewScreen extends StatefulWidget {
  const PracticeCardFirstViewScreen({Key? key}) : super(key: key);

  static const String id = 'card_first_view_screen';

  @override
  State<PracticeCardFirstViewScreen> createState() =>
      _PracticeCardFirstViewScreenState();
}

class _PracticeCardFirstViewScreenState
    extends State<PracticeCardFirstViewScreen> {
  FlashcardDatabase db = FlashcardDatabase();

  @override
  void initState() {
    db.loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(child: SizedBox()),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    size: 30.0,
                  ),
                ),
              ],
            ),
            const Expanded(child: SizedBox()),
            Flashcard(
              book: db.inProgressFlashcards[db.getListIndex()]['book'],
              chapter: db.inProgressFlashcards[db.getListIndex()]['chapter'],
              verse: db.inProgressFlashcards[db.getListIndex()]['verse'],
              verseText: db.inProgressFlashcards[db.getListIndex()]
                  ['verseText'],
            ),
            const Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(
                        context, PracticeCardHiddenViewScreen.id);
                  },
                  child: const Text('Hide Card to Test Yourself'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
