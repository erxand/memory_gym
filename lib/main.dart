import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:memory_gym/screens/add_card_screen.dart';
import 'package:memory_gym/screens/current_deck_screen.dart';
import 'package:memory_gym/screens/practice_card_screen.dart';
import 'package:memory_gym/screens/practice_screens/card_hidden_view.dart';
import 'package:memory_gym/screens/practice_screens/card_review_view.dart';
import 'package:memory_gym/screens/queued_cards_screen.dart';
import 'package:memory_gym/screens/finished_deck_screen.dart';
import 'package:memory_gym/screens/practice_screens/card_first_view.dart';

void main() async {
  // https://www.youtube.com/watch?v=mMgr47QBZWA
  // init the hive
  await Hive.initFlutter();

  // open some boxes
  var finishedCardsBox = await Hive.openBox('finishedCardsBox');
  var inProgressCardsBox = await Hive.openBox('inProgressCardsBox');
  var queuedCardsBox = await Hive.openBox('queuedCardsBox');
  var listIndexBox = await Hive.openBox('listIndexBox');

  runApp(const MemoryGym());
}

class MemoryGym extends StatelessWidget {
  const MemoryGym({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /*
      I got an error that said "A GlobalKey was used multiple times inside one widget's child list."
      Here's why I switched it to the home line:
      https://stackoverflow.com/questions/57673489/a-global-key-was-used-multiple-times-inside-one-widgets-child-list
      */
      // initialRoute: CurrentDeckScreen.id,
      home: const CurrentDeckScreen(),
      routes: {
        CurrentDeckScreen.id: (context) => const CurrentDeckScreen(),
        QueuedCardsScreen.id: (context) => const QueuedCardsScreen(),
        // PracticeCardScreen.id: (context) => const PracticeCardScreen(),
        AddCardScreen.id: (context) => const AddCardScreen(),
        PracticeCardFirstViewScreen.id: (context) =>
            const PracticeCardFirstViewScreen(),
        PracticeCardHiddenViewScreen.id: (context) =>
            const PracticeCardHiddenViewScreen(),
        PracticeCardReviewViewScreen.id: (context) =>
            const PracticeCardReviewViewScreen(),
      },
      theme: ThemeData.dark(),
    );
  }
}

// ESSENTIAL TO DOS

// KINDA ESSENTIAL TO DOS
// TODO: Automate adding cards to the current deck
// TODO: Make queued deck refresh immediately after adding a card *the right way* -- did I do this already?
// TODO: Give option to delete queued card or move it up/down on longpress
// TODO: Put progress stuff at the bottom of each current card
// TODO: Put progress bar at bottom of practice screen
// TODO: Make each card object have a counter, to see how many practices it has left
