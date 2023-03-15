import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../components/flashcard.dart';
import '../data/database.dart';

class PracticeCardScreen extends StatefulWidget {
  const PracticeCardScreen({Key? key}) : super(key: key);

  static const String id = 'practice_card_screen';

  @override
  State<PracticeCardScreen> createState() => _PracticeCardScreenState();
}

class _PracticeCardScreenState extends State<PracticeCardScreen> {
  final _queuedCardsBox = Hive.box('queuedCardsBox');
  FlashcardDatabase db = FlashcardDatabase();

  int cardIndex = 0;
  int pageTracker = 0;
  Column activeSetup = Column();

  // pageTracker Constants
  int beginningSetupID = 0;
  int testingSetupID = 1;
  int reviewingSetupID = 2;

  Column beginningSetup() {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: SizedBox()),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.home,
                size: 30.0,
              ),
            ),
          ],
        ),
        const Expanded(child: SizedBox()),
        Flashcard(
          book: db.inProgressFlashcards[cardIndex]['book'],
          chapter: db.inProgressFlashcards[cardIndex]['chapter'],
          verse: db.inProgressFlashcards[cardIndex]['verse'],
          verseText: db.inProgressFlashcards[cardIndex]['verseText'],
        ),
        const Expanded(child: SizedBox()),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  pageTracker = testingSetupID;
                });
              },
              child: const Text('Hide Card'),
            ),
          ),
        ),
      ],
    );
  }

  Column reviewingSetup() {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: SizedBox()),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.home,
                size: 30.0,
              ),
            ),
          ],
        ),
        const Expanded(child: SizedBox()),
        Flashcard(
          book: db.inProgressFlashcards[cardIndex]['book'],
          chapter: db.inProgressFlashcards[cardIndex]['chapter'],
          verse: db.inProgressFlashcards[cardIndex]['verse'],
          verseText: db.inProgressFlashcards[cardIndex]['verseText'],
        ),
        const Expanded(child: SizedBox()),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    pageTracker = testingSetupID;
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
                    cardIndex++;
                    pageTracker = beginningSetupID;
                  },
                  child: const Text('Next Card'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column testingSetup() {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: SizedBox()),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.home,
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
                setState(() {
                  pageTracker = reviewingSetupID;
                });
              },
              child: const Text('Reveal Card'),
            ),
          ),
        ),
      ],
    );
  }

  Scaffold practiceScreen() {
    if (pageTracker == beginningSetupID) {
      return Scaffold(
        body: SafeArea(
          child: beginningSetup(),
        ),
      );
    } else if (pageTracker == testingSetupID) {
      return Scaffold(
        body: SafeArea(
          child: testingSetup(),
        ),
      );
    } else if (pageTracker == reviewingSetupID) {
      return Scaffold(
        body: SafeArea(
          child: reviewingSetup(),
        ),
      );
    } else {
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
                      Icons.home,
                      size: 30.0,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    db.loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    activeSetup = beginningSetup();
    return practiceScreen();
  }
}
