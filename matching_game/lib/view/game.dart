import 'package:flutter/material.dart';
import 'package:matching_game/controller/matchManager.dart';
import 'package:matching_game/main.dart';
import 'package:matching_game/view/card/cardGrid.dart';
import 'package:matching_game/view/popups/completionPop.dart';
import 'package:provider/provider.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  void initState() {
    _setUp();
    super.initState();
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: _cachedImages(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error :(\n Check your connection)");
          }
          if (snapshot.hasData) {
            return Selector<MatchController, bool>(
                selector: (_, gameManager) => gameManager.complete,
                builder: (_, matchesCompleted, __) {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (timeStamp) async {
                      if (matchesCompleted) {
                        await showDialog(
                            //barrierColor: Colors.transparent,
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => const CompletedView());
                      }
                    },
                  );
                  return CardGrid(size: size);
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  void _setUp() {
    CardList.shuffle();
  }

  Future<int> _cachedImages() async {
    for (var card in CardList) {
      final image = Image.network(card.url);
      await precacheImage(image.image, context);
    }
    return 1;
  }
}


