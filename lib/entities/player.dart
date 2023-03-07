library player;

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Player {
  Player._() {
    readShopJson();
    shopUpgrades = List.filled(shopJsonData.length, 0, growable: true);
    stats = {
      "Dégats par clic": 1.0,
      "Dégats par secondes": 0.0,
      "Monstres battus": kill,
      "Clic": 0.0,
      "Or gagné": 0.0,
      "OR dépensé": 0.0,
      "Temps passé": 0.0,
      "dégats infligés": 0.0
    };
  }

  static final Player _instance = Player._();

  factory Player() {
    return _instance;
  }

  String name = "Allan";
  double money = 50;
  int tapAttack = 1;
  int passiveAttack = 0;
  double kill = 0.0;

  List shopJsonData = List.filled(0, null, growable: true);
  List<int> shopUpgrades = List.filled(0, 0, growable: true);

  late Map<String, double> stats;

  String gameMode = GameModes.story;
  Map<String, int> gameModesFloor = {"story": 1, "event1": 0};
  int floor = 0;

  String formattedMoney() {
    return NumberFormat.compactCurrency(decimalDigits: 2, symbol: '')
        .format(Player().money);
  }

  // Getters

  Future<void> readShopJson() async {
    final String response =
        await rootBundle.loadString('assets/upgrades/upgrades.json');
    final data = await json.decode(response);
    shopJsonData = data;
  }

  // Setters

  void giveMoney(int amount) {
    money += amount;
  }

  void nextFloor() {
    if (floor < 10) {
      floor++;
      print("Etape : $floor");
    } else {
      floor = 1;
      gameModesFloor.update(gameMode, (value) => value += 1);
      print("Etage : ${gameModesFloor[gameMode]}");
    }
  }
}

class GameModes {
  static String get story => "story";
  static String get event1 => "event1";
}
