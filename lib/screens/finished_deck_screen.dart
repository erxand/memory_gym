import 'package:flutter/material.dart';
import 'package:memory_gym/screens/current_deck_screen.dart';
import 'package:memory_gym/screens/practice_card_screen.dart';
import 'package:memory_gym/screens/queued_cards_screen.dart';

class FinishedDeckScreen extends StatefulWidget {
  const FinishedDeckScreen({Key? key}) : super(key: key);

  static const String id = 'finished_deck_screen';

  @override
  State<FinishedDeckScreen> createState() => _FinishedDeckScreenState();
}

class _FinishedDeckScreenState extends State<FinishedDeckScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TODO: Remove back arrow
        // TODO: Add drawer for extra buttons
        title: const Text('Finished Deck'),
      ),
      body: Column(
        children: [
          const Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                  'This will eventually contain all of the cards that have been practiced for 28 days'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                // TODO: Eventually make it so you can select to do so many cards at once, doing all of them isn't feasible if they have months' worth
                onPressed: () {
                  Navigator.pushNamed(context, PracticeCardScreen.id);
                },
                child: const Text('Practice All Finished Cards'),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.inventory_2)),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.home)),
            IconButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, QueuedCardsScreen.id);
              },
              icon: const Icon(Icons.playlist_add),
            ),
          ],
        ),
      ),
    );
  }
}
