import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:memory_gym/components/flashcard.dart';
import 'package:memory_gym/data/database.dart';
import 'package:memory_gym/screens/practice_screens/card_first_view.dart';
import 'package:memory_gym/screens/practice_screens/card_hidden_view.dart';

class PracticeCardReviewViewScreen extends StatefulWidget {
  const PracticeCardReviewViewScreen({Key? key}) : super(key: key);

  static const String id = 'card_review_view_screen';

  @override
  State<PracticeCardReviewViewScreen> createState() =>
      _PracticeCardReviewViewScreen();
}

class _PracticeCardReviewViewScreen
    extends State<PracticeCardReviewViewScreen> {
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
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () {
                        Navigator.popAndPushNamed(
                            context, PracticeCardHiddenViewScreen.id);
                      },
                      child: const Text('Hide Card Again'),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        db.incrementListIndex();
                        if (db.getListIndex() <
                            db.inProgressFlashcards.length) {
                          Navigator.popAndPushNamed(
                              context, PracticeCardFirstViewScreen.id);
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Next Card'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
