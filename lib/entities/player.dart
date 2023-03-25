library player;

import 'dart:convert';

import 'package:amaterasu/entities/equipment.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Player {
  // Singleton

  Player._() {
    readShopJson();
    shopUpgrades = List.filled(shopJsonData.length, 0, growable: true);
    stats = {
      "Dégats par clic": 0.0,
      "Dégats par secondes": 0.0,
      "Monstres battus": 0.0,
      "Clic": 0.0,
      "Or gagné": 0.0,
      "Or dépensé": 0.0,
      "Temps passé": 0.0,
      "Dégats infligés": 0.0
    };
  }

  static final Player _instance = Player._();

  factory Player() {
    return _instance;
  }

  // Identité

  String name = "Allan";

  int level = 1;
  int experience = 0;

  // Caractéristiques

  double totalAttack = 0.0;

  double health = 100.0;
  double armor = 0.00;

  double tapRegen = 0.0;
  double passiveRegen = 0.0;

  double tapAttack = 1.0;
  double passiveAttack = 0.0;

  double criticalChance = 0.00;
  double criticalMultiplier = 1.50;

  // Statistiques

  double kill = 0.0;

  // Propriétés

  double money = 0.0;

  List<Equipment> inventory = [];

  Map<String, Equipment?> equipments = {
    "head": null,
    "torso": null,
    "weapon": null,
    "legs": null
  };

  List shopJsonData = List.filled(0, null, growable: true);
  List<int> shopUpgrades = List.filled(0, 0, growable: true);

  late Map<String, double> stats;

  String gameMode = GameModes.story;
  Map<String, int> gameModesFloor = {"story": 1, "event1": 0};
  int floor = 0;

  // Getters

  String formattedMoney() {
    return NumberFormat.compactCurrency(decimalDigits: 2, symbol: '')
        .format(Player().money);
  }

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

  void spendMoney(int amount) {
    money -= amount;
  }

  void giveExp(int amount) {
    experience += amount;
  }

  void giveEquipmentById(int id) {
    inventory.add(Equipment.getEquipmentById(id));
    print(inventory);
  }

  void giveEquipment(Equipment equip) {
    inventory.add(equip);
  }

  void nextFloor() {
    if (floor < 10) {
      floor++;
    } else {
      floor = 1;
      gameModesFloor.update(gameMode, (value) => value += 1);
    }
  }

  void upgradeStat(String stat, int amount) {
    switch (stat) {
      case "dpc":
        {
          tapAttack = tapAttack + tapAttack * 0.1;
          break;
        }
      case "dps":
        {
          if (passiveAttack == 0) {
            passiveAttack = 1.0;
          } else {
            passiveAttack = passiveAttack + passiveAttack * 0.1;
          }
          break;
        }
      case "critChance":
        {
          if (criticalChance == 0) {
            criticalChance = 0.05;
          } else {
            criticalChance = criticalChance + criticalChance;
          }
          break;
        }
      case "critMultiplier":
        {
          criticalMultiplier = criticalMultiplier + 0.25;
          break;
        }
      case "health":
        {
          health = (health + health * 0.5).round() as double;
          break;
        }
      case "armor":
        {
          if (armor == 0) {
            armor = 0.02;
          } else {
            armor = armor + armor * 0.5;
          }
          break;
        }
      case "passiveRegen":
        {
          if (passiveRegen == 0) {
            passiveRegen = 0.05;
          } else {
            passiveRegen = passiveRegen + 0.01;
          }
          break;
        }
      case "tapRegen":
        {
          if (tapRegen == 0) {
            tapRegen = 0.001;
          } else {
            tapRegen = tapRegen + 0.001;
          }
          break;
        }
    }
  }
}

class GameModes {
  static String get story => "story";
  static String get event1 => "event1";
}
