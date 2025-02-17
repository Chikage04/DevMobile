import 'package:flutter/material.dart';
import 'package:tp3_demineur/view_models/game_view_model.dart';
import 'package:tp3_demineur/widgets/map_button.dart';
import 'package:tp3_demineur/game_arguments.dart';

class GameView extends StatefulWidget {
  static const routeName = '/game';

  const GameView({Key? key}) : super(key: key);

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  late GameViewModel viewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as GameArguments;
    viewModel = GameViewModel(
      nbLine: args.rows,
      nbCol: args.cols,
      nbBomb: args.bombs,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Démineur Simplifié'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                viewModel.generateMap(
                  nbLine: viewModel.nbLine,
                  nbCol: viewModel.nbCol,
                  nbBomb: viewModel.nbBomb,
                );
              });
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Difficulty: ${viewModel.nbLine}x${viewModel.nbCol} - ${viewModel.nbBomb} bombs',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Table(
              border: TableBorder.all(),
              children: List.generate(viewModel.nbLine, (row) {
                return TableRow(
                  children: List.generate(viewModel.nbCol, (col) {
                    final caseModel = viewModel.cases[row][col];
                    return MapButton(
                      row: row,
                      col: col,
                      iconPath: viewModel.getIcon(caseModel),
                      onTap: () {
                        setState(() {
                          viewModel.click(row, col);
                        });
                      },
                      onLongPress: () {
                        setState(() {
                          viewModel.onLongPress(row, col);
                        });
                      },
                    );
                  }),
                );
              }),
            ),
            const SizedBox(height: 20),
            if (viewModel.gameOver)
              const Text(
                'Game Over! You hit a bomb.',
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
            if (viewModel.gameWon)
              const Text(
                'You Win! Congratulations!',
                style: TextStyle(fontSize: 20, color: Colors.green),
              ),
          ],
        ),
      ),
    );
  }
}