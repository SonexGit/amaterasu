library enemy;

import 'dart:convert';
import 'dart:math';

import 'package:amaterasu/entities/player.dart';
import 'package:flutter/services.dart';

// Enums

enum LifeState { alive, dead }

enum EnemyType { common, boss }

Player player = Player();

class Enemy {
  // Singleton

  Enemy._() {
    readJson();
  }

  static final Enemy _instance = Enemy._();

  factory Enemy() {
    return _instance;
  }

  // Attributes

  List jsonData = List.empty(growable: true);
  String name = "";
  LifeState state = LifeState.alive;
  int health = 1;
  int maxHealth = 1;
  int moneyValue = 0;
  int expValue = 0;
  int id = 1;
  late EnemyType type;

  // Getters

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/enemies/enemies.json');
    final data = await json.decode(response);
    jsonData = data;
  }

  int getHealth() {
    return health;
  }

  int getMaxHealth() {
    return maxHealth;
  }

  // Setters

  void loseHealth(double damage) {
    if (state != LifeState.dead) {
      if (health - damage > 0) {
        health -= damage.round();
      } else {
        health = 0;
        death();
      }
    }
  }

  void death() {
    state = LifeState.dead;
    player.giveMoney(moneyValue);
    player.giveExp(expValue);
    // TODO : give items?
    player.nextFloor();
    newEnemy(
        player.gameMode, player.gameModesFloor[player.gameMode], player.floor);
  }

  void newEnemy(gameMode, gameModeFloor, step) {
    int rand;
    if (step != 10) {
      do {
        rand = Random().nextInt(jsonData.length);
      } while (jsonData[rand]["type"] == EnemyType.boss.index);
    } else {
      do {
        rand = Random().nextInt(jsonData.length);
      } while (jsonData[rand]["type"] != EnemyType.boss.index);
    }
    name = jsonData[rand]["name"];
    health = jsonData[rand]["health"] * player.gameModesFloor[player.gameMode];
    maxHealth =
        jsonData[rand]["health"] * player.gameModesFloor[player.gameMode];
    moneyValue = jsonData[rand]["moneyValue"];
    id = jsonData[rand]["id"];
    type = EnemyType.values[jsonData[rand]["type"]];
    expValue = jsonData[rand]["expValue"];
    state = LifeState.alive;
  }
}
