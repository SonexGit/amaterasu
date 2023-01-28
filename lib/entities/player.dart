library player;

import 'package:intl/intl.dart';

class Player {  

  Player._();

  static final Player _instance = Player._();

  factory Player() {
    return _instance;
  }

  String name = "Allan";
  int money = 3870;

  String formattedMoney() { 
    return NumberFormat.compactCurrency(decimalDigits: 2, symbol: '').format(Player().money);
  }

}