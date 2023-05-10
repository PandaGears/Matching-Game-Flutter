import 'dart:math';

import 'package:flutter/material.dart';
import 'package:matching_game/controller/matchManager.dart';
import 'package:matching_game/model/playingCard.dart';
import 'package:matching_game/view/animation/flip.dart';
import 'package:provider/provider.dart';

class Cards extends StatelessWidget {
  const Cards({super.key, required this.index, required this.playingCard});

  final int index;
  final PlayingCard playingCard;

  @override
  Widget build(BuildContext context) {
    return Consumer<MatchController>(builder: (_, notifier, __) {
      bool animate = canAnimate(notifier);

      return GestureDetector(
          onTap: () {
            if (!notifier.ignoreGesture &&
                !notifier.correctGuesses.contains(index) &&
                !notifier.tappedCards.containsKey(index)) {}
            notifier.cardSelected(index: index, card: playingCard);
          },
          child: FlipAnimation(
              delay: notifier.reverseFlip ? 1200 : 0,
              returnAnimate: notifier.reverseFlip,
              animationComplete: (isFront) {
                notifier.onAnimationCompleted(isFacingFront: isFront);
              },
              animate: animate,
              card: Container(
                  padding: const EdgeInsets.all(16),
                  child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(pi),
                      child: Image.network(playingCard.url)))));
    });
  }

  bool canAnimate(MatchController notifier) {
    bool animate = false;
    if (notifier.canFlip) {
      if (notifier.tappedCards.isNotEmpty &&
          notifier.tappedCards.keys.last == index) {
        animate = true;
      }
      if (notifier.reverseFlip &&
          !notifier.correctGuesses.contains((index))) {
        animate = true;
      }
    }
    return animate;
  }
}
