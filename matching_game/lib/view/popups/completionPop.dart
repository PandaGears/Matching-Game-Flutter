import 'package:flutter/material.dart';
import 'package:matching_game/main.dart';

class CompletedView extends StatelessWidget {
  const CompletedView({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white10,
      title: Text("Congratulations on completion", textAlign: TextAlign.center,),
      titleTextStyle: TextStyle(fontSize: 50),
      actions: [ Container(
        padding: EdgeInsets.all(30),
        width: double.infinity,
        child: ElevatedButton(onPressed: () {
          Navigator.pushAndRemoveUntil(context, 
          PageRouteBuilder(pageBuilder: (_,__,___) => MyApp()), (route) => false);
        }, child: Text("Try Again?"))
      )
      ],
    );
  }
}