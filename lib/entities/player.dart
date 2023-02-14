library player;

import 'package:intl/intl.dart';

class GameModes {
  static String get story => "story";
  static String get event1 => "event1";
}

class Player {
  Player._();

  static final Player _instance = Player._();

  factory Player() {
    return _instance;
  }

  String name = "Allan";
  int money = 0;
  int tapAttack = 1;
  int passiveAttack = 0;

  String gameMode = GameModes.story;
  Map<String, int> gameModesFloor = {"story": 1, "event1": 0};

  String formattedMoney() {
    return NumberFormat.compactCurrency(decimalDigits: 2, symbol: '')
        .format(Player().money);
  }

  // SETTERS

  void giveMoney(int amount) {
    money += amount;
  }
}
