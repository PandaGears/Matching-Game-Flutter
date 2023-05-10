import 'package:flutter/material.dart';
import 'package:matching_game/model/playingCard.dart';

class MatchController extends ChangeNotifier {
  Map<int, PlayingCard> tappedCards = {};
  int index = 0;
  bool canFlip = false;
  bool reverseFlip = false;
  bool ignoreGesture = false;
  bool complete = false;
  List<int> correctGuesses = [];

  void cardSelected({required int index, required PlayingCard card}) {
    ignoreGesture = true;
    if (tappedCards.length <= 1) {
      tappedCards.addEntries([MapEntry(index, card)]);
      canFlip = true;
    } else {
      canFlip = false;
    }
    notifyListeners();
  }

  onAnimationCompleted({required bool isFacingFront}) {
    if (tappedCards.length == 2) {
      if (isFacingFront) {
        if (containsAny(tappedCards.entries.elementAt(0).value.text,
            tappedCards.entries.elementAt(1).value.text)) {
          correctGuesses.addAll(tappedCards.keys);
          if (correctGuesses.length == 26) {
            complete = true;
          }
          tappedCards.clear();
          canFlip = true;
          ignoreGesture = false;
        } else {
          reverseFlip = true;
        }
      } else {
        reverseFlip = false;
        tappedCards.clear();
        ignoreGesture = false;
      }
    } else {
      canFlip = false;
      ignoreGesture = false;
    }
    notifyListeners();
  }

  bool containsAny(String text, String substring) {
    if (text.contains(substring) || substring.contains(text)) {
      return true;
    } else {
      return false;
    }
  }
}
