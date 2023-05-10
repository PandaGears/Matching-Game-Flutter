import 'package:flutter/material.dart';
import 'package:matching_game/main.dart';
import 'package:matching_game/view/card/card.dart';

class CardGrid extends StatelessWidget {
  const CardGrid({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return ColoredSafeArea(
        color: Colors.black,
        child: Center(
            child: GridView.builder(
          shrinkWrap: true,
          itemCount: 26,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 8,
            crossAxisSpacing: 1,
            mainAxisSpacing: 0.0001,
            mainAxisExtent: size.height * 0.25,
          ),
          itemBuilder: (context, index) => Cards(
            index: index,
            playingCard: CardList[index],
          ),
        )));
  }
}

class ColoredSafeArea extends StatelessWidget {
  final Widget child;
  final Color? color;

  const ColoredSafeArea({
    Key? key,
    required this.child,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? Theme.of(context).appBarTheme.backgroundColor,
      child: SafeArea(
        child: Container(
          color: Theme.of(context).colorScheme.background,
          child: child,
        ),
      ),
    );
  }
}
