import 'package:flutter/material.dart';
import 'package:tp3_demineur/models/map_model.dart';
import 'package:tp3_demineur/models/case_model.dart';

class GameViewModel {
  late MapModel mapModel;

  GameViewModel({required int nbLine, required int nbCol, required int nbBomb}) {
    mapModel = MapModel(nbLine: nbLine, nbCol: nbCol, nbBomb: nbBomb);
  }

  int get nbLine => mapModel.nbLine;
  int get nbCol => mapModel.nbCol;
  int get nbBomb => mapModel.nbBomb;
  List<List<CaseModel>> get cases => mapModel.cases;
  bool get gameOver => mapModel.gameOver;
  bool get gameWon => mapModel.gameWon;

  void generateMap({required int nbLine, required int nbCol, required int nbBomb}) {
    mapModel = MapModel(nbLine: nbLine, nbCol: nbCol, nbBomb: nbBomb);
  }

  void click(int row, int col) {
    mapModel.reveal(row, col);
  }

  void onLongPress(int row, int col) {
    mapModel.toggleFlag(row, col);
  }

  String getIcon(CaseModel caseModel) {
    if (!caseModel.hidden) {
      if (caseModel.hasBomb) {
        return 'assets/images/bomb_exploded.png';
      } else if (caseModel.number != null && caseModel.number! > 0) {
        return 'assets/images/${caseModel.number}.png';
      } else {
        return 'assets/images/empty.png';
      }
    } else {
      if (caseModel.hasFlag) {
        return 'assets/images/flag.png';
      } else {
        return 'assets/images/hidden.png';
      }
    }
  }
}