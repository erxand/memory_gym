import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:memory_gym/components/flashcard.dart';
import 'package:memory_gym/data/database.dart';
import 'package:memory_gym/screens/practice_screens/card_review_view.dart';

class PracticeCardHiddenViewScreen extends StatefulWidget {
  const PracticeCardHiddenViewScreen({Key? key}) : super(key: key);

  static const String id = 'card_hidden_view_screen';

  @override
  State<PracticeCardHiddenViewScreen> createState() =>
      _PracticeCardHiddenViewScreen();
}

class _PracticeCardHiddenViewScreen
    extends State<PracticeCardHiddenViewScreen> {
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(
                        context, PracticeCardReviewViewScreen.id);
                  },
                  child: const Text('Check Accuracy'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
