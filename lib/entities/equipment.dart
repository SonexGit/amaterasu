import 'dart:convert';

import 'package:amaterasu/entities/player.dart';
import 'package:flutter/services.dart';

enum EquipRarity { common, rare, epic, legendary }

enum EquipType { head, body, legs, weapon }

Player player = Player();

class Equipment {
  final int id;
  final String name;
  final String desc;
  final int price;
  final EquipRarity rarity;
  final int requiredFloor;
  final EquipType? type;
  final double? healthBonus;
  final double? armorBonus;
  final double? tapAttackBonus;
  final double? passiveAttackBonus;
  final double? tapRegenBonus;
  final double? passiveRegenBonus;
  final double? criticalChanceBonus;
  final double? criticalMultiplierBonus;

  static List<Equipment> shopEquipments = [];

  Equipment({
    required this.id,
    required this.name,
    required this.desc,
    required this.price,
    required this.rarity,
    required this.requiredFloor,
    this.type,
    this.healthBonus,
    this.armorBonus,
    this.tapAttackBonus,
    this.passiveAttackBonus,
    this.tapRegenBonus,
    this.passiveRegenBonus,
    this.criticalChanceBonus,
    this.criticalMultiplierBonus,
  });

  factory Equipment.fromJson(Map<String, dynamic> json) {
    return Equipment(
      id: json["id"],
      name: json["name"],
      desc: json["desc"],
      price: json["price"],
      rarity: EquipRarity.values[json["rarity"]],
      requiredFloor: json["requiredFloor"],
      type: EquipType.values[json["type"]],
      healthBonus: json["healthBonus"],
      armorBonus: json["armorBonus"],
      tapAttackBonus: json["tapAttackBonus"],
      passiveAttackBonus: json["passiveAttackBonus"],
      tapRegenBonus: json["tapRegenBonus"],
      passiveRegenBonus: json["passiveRegenBonus"],
      criticalChanceBonus: json["criticalChanceBonus"],
      criticalMultiplierBonus: json["criticalMultiplierBonus"],
    );
  }

  static List<Equipment> equipmentList = List<Equipment>.filled(
      0,
      Equipment(
          id: 0,
          name: "",
          desc: "",
          price: 0,
          rarity: EquipRarity.common,
          requiredFloor: 0),
      growable: true);

  static Equipment getEquipmentById(int id) {
    return equipmentList.firstWhere((equip) => equip.id == id);
  }

  String typeToString() {
    return type.toString().split('.').last;
  }

  static String typeArgToString(EquipType type) {
    return type.toString().split('.').last;
  }

  static Future<void> setupEquipments() async {
    await readEquipmentJson();
    generateShopEquipment();
  }

  static Future<void> readEquipmentJson() async {
    final String response =
        await rootBundle.loadString('assets/equipments/equipments.json');
    final List data = await json.decode(response);
    equipmentList = data.map((json) => Equipment.fromJson(json)).toList();
  }

  static generateShopEquipment() {
    shopEquipments = [
      getEquipmentById(1),
      getEquipmentById(2),
      getEquipmentById(3)
    ];
  }
}
