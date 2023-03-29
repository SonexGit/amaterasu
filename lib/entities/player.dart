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

  String locale = "fr";

  // Caractéristiques

  double totalAttack = 0.0;

  double health = 100.0;
  double armor = 0.00;

  double tapRegen = 0.0;
  double passiveRegen = 0.0;

  double tapAttack = 30.0;
  double passiveAttack = 1.0;

  double criticalChance = 0.00;
  double criticalMultiplier = 1.50;

  double healthBonus = 0.00;
  double armorBonus = 0.00;
  double tapRegenBonus = 0.00;
  double passiveRegenBonus = 0.00;
  double tapAttackBonus = 0.00;
  double passiveAttackBonus = 0.00;
  double criticalChanceBonus = 0.00;
  double criticalMultiplierBonus = 0.00;

  List<bool> dailyQuestsStatus = List.generate(3, (_) => false);
  List<bool> monthlyQuestsStatus = List.generate(3, (_) => false);

  bool isButtonClicked0 = false;
  bool isButtonClicked1 = false;
  bool isButtonClicked2 = false;
  bool isButtonClickedM0 = false;
  bool isButtonClickedM1 = false;
  bool isButtonClickedM2 = false;

  double kill = 0.0;

  // Propriétés

  double money = 10000.0;

  List<Equipment> inventory = [];

  Map<String, Equipment?> equipments = {
    "head": null,
    "body": null,
    "legs": null,
    "weapon": null
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

  double getEquippedBonus(String bonus) {
    double totalBonus = 0.0;
    equipments.forEach((key, value) {
      if (value != null) {
        switch (bonus) {
          case "tapAttackBonus":
            totalBonus += value.tapAttackBonus!;
            break;
          case "passiveAttackBonus":
            totalBonus += value.passiveAttackBonus!;
            break;
          case "tapRegenBonus":
            totalBonus += value.tapRegenBonus!;
            break;
          case "passiveRegenBonus":
            totalBonus += value.passiveRegenBonus!;
            break;
          case "healthBonus":
            totalBonus += value.healthBonus!;
            break;
          case "armorBonus":
            totalBonus += value.armorBonus!;
            break;
          case "criticalChanceBonus":
            totalBonus += value.criticalChanceBonus!;
            break;
          case "criticalMultiplierBonus":
            totalBonus += value.criticalMultiplierBonus!;
            break;
          default:
            // Bonus inconnu
            break;
        }
      }
    });
    return totalBonus;
  }

  double getTapAttack() {
    return tapAttack + getEquippedBonus("tapAttackBonus");
  }

  double getPassiveAttack() {
    return passiveAttack + getEquippedBonus("passiveAttackBonus");
  }

  double getTapRegen() {
    return tapRegen + getEquippedBonus("tapRegenBonus");
  }

  double getPassiveRegen() {
    return passiveRegen + getEquippedBonus("passiveRegenBonus");
  }

  double getHealth() {
    return health + getEquippedBonus("healthBonus");
  }

  double getArmor() {
    return armor + getEquippedBonus("armorBonus");
  }

  double getCriticalChance() {
    return criticalChance + getEquippedBonus("criticalChanceBonus");
  }

  double getCriticalMultiplier() {
    return criticalMultiplier + getEquippedBonus("criticalMultiplierBonus");
  }

  // Setters

  void setLocale(String loc) {
    locale = loc;
  }

  void giveMoney(int amount) {
    money += amount;
  }

  void spendMoney(int amount) {
    money -= amount;
  }

  void giveExp(int amount) {
    experience += amount;
  }

  void equip(Equipment equip) {
    equipments[equip.typeToString()] = equip; 
  }

  void giveEquipmentById(int id) {
    inventory.add(Equipment.getEquipmentById(id));
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
