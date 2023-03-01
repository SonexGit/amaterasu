library enemy;

import 'dart:convert';
import 'dart:io';
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
  int id = 1;

  // Getters

  Future<void> readJson() {
    final String response =
        await rootBundle.loadString('assets/enemies/enemies.json');
    final data = await json.decode(response);
    jsonData = data;
    print("Fini de lire le JSON");
  }

  int getHealth() {
    return health;
  }

  int getMaxHealth() {
    return maxHealth;
  }

  // Setters

  void loseHealth(int damage) {
    if (state != LifeState.dead) {
      if (health - damage > 0) {
        health -= damage;
      } else {
        health = 0;
        death();
      }
    }
  }

  void death() {
    state = LifeState.dead;
    player.giveMoney(moneyValue);
    // give items?
    newEnemy(player.gameMode, player.gameModesFloor[player.gameMode]);
  }

  void newEnemy(gameMode, floor) {
    print("JSONDATA : $jsonData");
    var rand = Random().nextInt(jsonData.length);
    name = jsonData[rand]["name"];
    health = jsonData[rand]["health"];
    maxHealth = jsonData[rand]["health"];
    moneyValue = jsonData[rand]["moneyValue"];
    id = jsonData[rand]["id"];
    state = LifeState.alive;
  }
}
