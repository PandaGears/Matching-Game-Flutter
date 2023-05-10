import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matching_game/controller/matchManager.dart';
import 'package:matching_game/model/playingCard.dart';
import 'package:matching_game/view/game.dart';
import 'package:matching_game/view/theme/appTheme.dart';
import 'package:provider/provider.dart';

List<PlayingCard> CardList = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);




  runApp(FutureBuilder(
    future: createCards(),
    builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error :( \n Check your connection )');
        } if (snapshot.hasData) {
          return const MyApp();
        } else {
          return Center(child: CircularProgressIndicator(),);
        }
      }
      )
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Matching Game',
      theme:  appTheme,
      home: Material(child: ChangeNotifierProvider(
        create: (context) => MatchController(),
        child: Game())),
    );
  }
}

Future<int> createCards() async {
  final ref = FirebaseStorage.instance.ref();
  final all = await ref.listAll();

  for (var card in all.items) {
    CardList.add(PlayingCard(text: card.name.substring(0, card.name.indexOf('.')), url: await card.getDownloadURL()));
  }
  return 1;
}
