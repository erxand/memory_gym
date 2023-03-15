import 'package:hive_flutter/hive_flutter.dart';

class FlashcardDatabase {
  List inProgressFlashcards = [];
  List queuedFlashcards = [];

  // Define keywords so I don't have typos
  String inProgressKeyword = 'IN PROGRESS FLASHCARDS';
  String queuedKeyword = 'QUEUED FLASHCARDS';
  String listIndexKeyword = 'LIST INDEX';

  // reference the boxes
  final _inProgressCardsBox = Hive.box('inProgressCardsBox');
  final _queuedCardsBox = Hive.box('queuedCardsBox');
  final _listIndexBox = Hive.box('listIndexBox');

  int getListIndex() {
    return _listIndexBox.get(listIndexKeyword);
  }

  void resetListIndex() {
    _listIndexBox.put(listIndexKeyword, 0);
  }

  void incrementListIndex() {
    _listIndexBox.put(listIndexKeyword, getListIndex() + 1);
  }

  // load the data from database  **box -> list
  void loadData() {
    try {
      inProgressFlashcards = _inProgressCardsBox
          .get(inProgressKeyword); // this line caused the error
    } catch (e) {
      print('loadData error inProgress with $e');
    }
    try {
      queuedFlashcards = _queuedCardsBox.get(queuedKeyword);
    } catch (e) {
      print('loadData error queued with $e');
    }
  }

  // update the database  **list -> box
  void updateDatabase() {
    _inProgressCardsBox.put(inProgressKeyword, inProgressFlashcards);
    if (queuedFlashcards != []) {
      _queuedCardsBox.put(queuedKeyword, queuedFlashcards);
    }
  }
}
