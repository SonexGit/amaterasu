library player;

import 'dart:convert';
import 'dart:math';

import 'package:amaterasu/entities/equipment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Player {
  // Singleton

  Player._() {
    readUpgradeJson();
    nextLevelExp = (500 * pow(1.1, getLevel()) - 500).round();
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
  String name = "";

  int level = 1;
  int experience = 0;
  late int nextLevelExp = 0;

  String locale = "fr";

  bool haveSeenTutorial = false;

  // Caractéristiques

  double totalAttack = 0.0;

  double health = 100.0;
  double armor = 0.00;

  double tapRegen = 0.0;
  double passiveRegen = 0.0;

  double tapAttack = 1.0;
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
  double criticalMultiplierBonus = 2.00;

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

  double money = 0.0;
  int lastAfkIncome = 0;

  List<Equipment> inventory = [];
  int inventoryFilterIndex = 0;
  int inventoryOrderIndex = 0;

  Map<String, Equipment?> equipments = {
    "head": null,
    "body": null,
    "legs": null,
    "weapon": null
  };

  List<double> upgradesMultiplier = List.filled(0, 0, growable: true);

  List shopJsonData = List.filled(0, null, growable: true);
  List<int> shopUpgrades = List.filled(0, 0, growable: true);

  List<int> upgradesLevel = List.filled(8, 0, growable: false);

  late Map<String, double> stats;

  String gameMode = GameModes.story;
  Map<String, int> gameModesFloor = {"story": 1, "event1": 0};
  int floor = 0;

  // Getters

  String formattedMoney() {
    return NumberFormat.compactCurrency(decimalDigits: 0, symbol: '')
        .format(Player().money);
  }

  Future<void> readUpgradeJson() async {
    final String response =
        await rootBundle.loadString('assets/upgrades/upgrades_$locale.json');
    final data = await json.decode(response);
    shopJsonData = data;
    for (int i = 0; i < data.length; i++) {
      double multiplier = data[i]['multiplier'].toDouble();
      upgradesMultiplier.add(multiplier);
    }
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

  double getUpgradeBonus(int index) {
    double totalBonus = 0.0;
    totalBonus = upgradesLevel[index] * upgradesMultiplier[index];
    return totalBonus;
  }

  void buy(int amount) {
    player.money -= amount;
  }

  double attack() {
    final randomNum = Random().nextInt(101);

    if (getCriticalMultiplier() > 0.0 &&
        getCriticalChance() > 0.0 &&
        randomNum > (getCriticalChance() * 100).round()) {
      // Critical hit
      return getTapAttack() * getCriticalMultiplier();
    } else {
      // Normal hit
      return getTapAttack();
    }
  }

  int getLevel() {
    return level;
  }

  double getTapAttack() {
    return tapAttack + getEquippedBonus("tapAttackBonus") + getUpgradeBonus(0);
  }

  double getPassiveAttack() {
    return passiveAttack +
        getEquippedBonus("passiveAttackBonus") +
        getUpgradeBonus(1);
  }

  double getTapRegen() {
    return tapRegen + getEquippedBonus("tapRegenBonus") + getUpgradeBonus(2);
  }

  double getPassiveRegen() {
    return passiveRegen +
        getEquippedBonus("passiveRegenBonus") +
        getUpgradeBonus(3);
  }

  double getHealth() {
    return health + getEquippedBonus("healthBonus") + getUpgradeBonus(4);
  }

  double getArmor() {
    return armor + getEquippedBonus("armorBonus") + getUpgradeBonus(5);
  }

  double getCriticalChance() {
    return criticalChance +
        getEquippedBonus("criticalChanceBonus") +
        getUpgradeBonus(6);
  }

  double getCriticalMultiplier() {
    return criticalMultiplier +
        getEquippedBonus("criticalMultiplierBonus") +
        getUpgradeBonus(7);
  }

  int getUpgradeLevel(int index) {
    return upgradesLevel[index];
  }

  static String getFilterLocalization(BuildContext context, int index) {
    List<String> filters = [
      AppLocalizations.of(context)!.dateObtained,
      AppLocalizations.of(context)!.rarity,
      AppLocalizations.of(context)!.levelRequired,
      AppLocalizations.of(context)!.type
    ];
    return filters[index];
  }

  static List<String> getFiltersLocalization(BuildContext context) {
    return [
      AppLocalizations.of(context)!.dateObtained,
      AppLocalizations.of(context)!.rarity,
      AppLocalizations.of(context)!.levelRequired,
      AppLocalizations.of(context)!.type
    ];
  }

  static String getOrderLocalization(BuildContext context, int index) {
    List<String> orders = [
      AppLocalizations.of(context)!.descending,
      AppLocalizations.of(context)!.ascending
    ];
    return orders[index];
  }

  static List<String> getOrdersLocalization(BuildContext context) {
    return [
      AppLocalizations.of(context)!.descending,
      AppLocalizations.of(context)!.ascending
    ];
  }

  // Setters

  late Future<List<Map<String, dynamic>>> dailyQuestsFuture;
  late Future<List<Map<String, dynamic>>> monthlyQuestsFuture;

  Future<List<Map<String, dynamic>>> loadQuestsData(String filePath) async {
    try {
      String jsonData = await rootBundle.loadString(filePath);
      List<dynamic> data = json.decode(jsonData);
      List<Map<String, dynamic>> quests = List<Map<String, dynamic>>.from(data);
      return quests;
    } catch (error) {
      throw ErrorDescription('Erreur de chargement de données: $error');
    }
  }

  void setupQuests() {
    dailyQuestsFuture =
        loadQuestsData('assets/quests/daily_quests_$locale.json');
    monthlyQuestsFuture =
        loadQuestsData('assets/quests/monthly_quests_$locale.json');
  }

  void setLocale(String loc) {
    locale = loc;
    readUpgradeJson();
    Equipment.setupEquipments();
    setupQuests();
  }

  void giveMoney(int amount) {
    money += amount;
  }

  void spendMoney(int amount) {
    money -= amount;
  }

  void giveExp(int amount) {
    experience += amount;
    while (experience >= nextLevelExp) {
      level++;
      experience -= nextLevelExp;
      nextLevelExp += (500 * pow(1.1, level - 1) - 500).round();
    }
  }

  void giveAfkMoney(DateTime quitTime, DateTime nowTime) {
    // Calcul de la différence entre quitTime et nowTime en secondes
    int secondsElapsed = nowTime.difference(quitTime).inSeconds;

    if (secondsElapsed > 36000) {
      secondsElapsed = 36000; // Limiter la différence à 10 heures
    }

    // TODO : changer le 1 par le taux de money par seconde
    lastAfkIncome = secondsElapsed * 1;
    money += lastAfkIncome;
  }

  void equip(Equipment equip) {
    equipments[equip.typeToString()] = equip;
  }

  void giveEquipmentById(int id) {
    inventory
        .add(Equipment.getEquipmentById(id).setObtainedDate(DateTime.now()));
  }

  void giveEquipment(Equipment equip) {
    inventory.add(equip.setObtainedDate(DateTime.now()));
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

  void levelUpUpgrade(int index) {
    upgradesLevel[index]++;
  }

  void updateOrder(int orderIndex) {
    inventoryOrderIndex = orderIndex;
    updateInventorySort();
  }

  void updateFilter(int filterIndex) {
    inventoryFilterIndex = filterIndex;
    updateInventorySort();
  }

  void updateInventorySort() {
    switch (inventoryFilterIndex) {
      case 0:
        inventoryOrderIndex == 0
            ? inventory
                .sort((a, b) => b.obtainedDate!.compareTo(a.obtainedDate!))
            : inventory
                .sort((a, b) => a.obtainedDate!.compareTo(b.obtainedDate!));
        break;
      case 1:
        inventoryOrderIndex == 0
            ? inventory.sort((a, b) => b.rarity.order.compareTo(a.rarity.order))
            : inventory
                .sort((a, b) => a.rarity.order.compareTo(b.rarity.order));
        break;
      case 2:
        inventoryOrderIndex == 0
            ? inventory
                .sort((a, b) => b.requiredLevel.compareTo(a.requiredLevel))
            : inventory
                .sort((a, b) => a.requiredLevel.compareTo(b.requiredLevel));
        break;
      case 3:
        inventoryOrderIndex == 0
            ? inventory.sort((a, b) => b.type.order.compareTo(a.type.order))
            : inventory.sort((a, b) => a.type.order.compareTo(b.type.order));
        break;
      default:
        break;
    }
  }
}

class GameModes {
  static String get story => "story";
  static String get event1 => "event1";
}
