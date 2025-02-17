import 'dart:math';
import 'package:tp3_demineur/models/case_model.dart';

class MapModel {
  int nbLine = 0;
  int nbCol = 0;
  int nbBomb = 0;
  List<List<CaseModel>> cases = [];
  bool gameOver = false;
  bool gameWon = false;

  MapModel({
    required this.nbLine,
    required this.nbCol,
    required this.nbBomb,
  }) {
    generateMap();
  }

  void generateMap() {
    cases = initCases();
    initBomb();
    initNumbers();
    gameOver = false;
    gameWon = false;
  }

  List<List<CaseModel>> initCases() {
    return List.generate(
      nbLine,
      (row) => List.generate(
        nbCol,
        (col) => CaseModel(),
      ),
    );
  }

  void initBomb() {
    Random random = Random();
    int bombsPlaced = 0;
    while (bombsPlaced < nbBomb) {
      int row = random.nextInt(nbLine);
      int col = random.nextInt(nbCol);
      if (!cases[row][col].hasBomb) {
        cases[row][col].hasBomb = true;
        bombsPlaced++;
      }
    }
  }

  void initNumbers() {
    for (int i = 0; i < nbLine; i++) {
      for (int j = 0; j < nbCol; j++) {
        if (!cases[i][j].hasBomb) {
          cases[i][j].number = computeNumber(i, j);
        }
      }
    }
  }

  int computeNumber(int row, int col) {
    int bombCount = 0;
    for (int i = -1; i <= 1; i++) {
      for (int j = -1; j <= 1; j++) {
        if (i == 0 && j == 0) continue;
        CaseModel? neighbor = tryGetCase(row + i, col + j);
        if (neighbor != null && neighbor.hasBomb) {
          bombCount++;
        }
      }
    }
    return bombCount;
  }

  CaseModel? tryGetCase(int row, int col) {
    if (row >= 0 && row < nbLine && col >= 0 && col < nbCol) {
      return cases[row][col];
    }
    return null;
  }

  void reveal(int row, int col) {
    if (gameOver || gameWon || !cases[row][col].hidden || cases[row][col].hasFlag) {
      return;
    }

    cases[row][col].hidden = false;

    if (cases[row][col].hasBomb) {
      explode(row, col);
      return;
    }

    if (cases[row][col].number == 0) {
      revealAdjacents(row, col);
    }
    checkWin();
  }

  void revealAdjacents(int row, int col) {
    for (int i = -1; i <= 1; i++) {
      for (int j = -1; j <= 1; j++) {
        if (i == 0 && j == 0) continue;
        CaseModel? neighbor = tryGetCase(row + i, col + j);
        if (neighbor != null && neighbor.hidden && !neighbor.hasFlag) {
          reveal(row + i, col + j);
        }
      }
    }
  }

  void revealAll() {
    for (int i = 0; i < nbLine; i++) {
      for (int j = 0; j < nbCol; j++) {
        cases[i][j].hidden = false;
      }
    }
  }

  void explode(int row, int col) {
    gameOver = true;
    cases[row][col].hasExploded = true;
    revealAll();
  }

  void toggleFlag(int row, int col) {
    if (gameOver || gameWon || !cases[row][col].hidden) {
      return;
    }
    cases[row][col].hasFlag = !cases[row][col].hasFlag;
  }

  void checkWin() {
    int hiddenNonBombs = 0;
    for (int i = 0; i < nbLine; i++) {
      for (int j = 0; j < nbCol; j++) {
        if (cases[i][j].hidden && !cases[i][j].hasBomb) {
          hiddenNonBombs++;
        }
      }
    }
    if (hiddenNonBombs == 0) {
      gameWon = true;
      revealAll();
    }
  }
}