library enemy;

import 'package:amaterasu/entities/player.dart';

enum LifeState { alive, dead }

Player player = Player();

class Enemy {
  Enemy._();

  static final Enemy _instance = Enemy._();

  factory Enemy() {
    return _instance;
  }

  String name = "Zombie";
  LifeState state = LifeState.alive;
  int health = 30;
  int maxHealth = 30;
  int moneyValue = 14;

  // GETTERS

  int getHealth() {
    return health;
  }

  int getMaxHealth() {
    return maxHealth;
  }

  // SETTERS

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
    // à faire
  }
}
