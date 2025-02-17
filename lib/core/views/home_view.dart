import 'package:flutter/material.dart';
import 'package:tp3_demineur/views/game_view.dart';
import 'package:tp3_demineur/game_arguments.dart';

class HomeView extends StatelessWidget {
  static const routeName = '/home';

  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Démineur'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Choose Difficulty',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  GameView.routeName,
                  arguments: GameArguments(rows: 10, cols: 8, bombs: 10),
                );
              },
              child: const Text('Easy (10x8, 10 bombs)'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  GameView.routeName,
                  arguments: GameArguments(rows: 18, cols: 14, bombs: 40),
                );
              },
              child: const Text('Medium (18x14, 40 bombs)'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  GameView.routeName,
                  arguments: GameArguments(rows: 24, cols: 20, bombs: 99),
                );
              },
              child: const Text('Hard (24x20, 99 bombs)'),
            ),
          ],
        ),
      ),
    );
  }
}