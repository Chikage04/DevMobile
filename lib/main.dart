import 'package:flutter/material.dart';
import 'package:tp3_demineur/views/home_view.dart';
import 'package:tp3_demineur/views/game_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Démineur',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: HomeView.routeName,
      routes: {
        HomeView.routeName: (context) => const HomeView(),
        GameView.routeName: (context) => const GameView(),
      },
    );
  }
}