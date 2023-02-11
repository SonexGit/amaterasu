library enemy;

class Enemy {
  Enemy._();

  static final Enemy _instance = Enemy._();

  factory Enemy() {
    return _instance;
  }

  String name = "Zombie";
  int health = 30;
  int maxHealth = 30;

  // GETTERS

  int getHealth() {
    return health;
  }

  int getMaxHealth() {
    return maxHealth;
  }

  // SETTERS

  void death() {
    // give golds
    // give items?
    // create new enemy
  }

  void newEnemy(mode, floor) {
    // à faire
  }

  void loseHealth(int damage) {
    if (health - damage > 0) {
      health -= damage;
    } else {
      health = 0;
    }
  }
}
