import 'dart:convert';

import 'package:amaterasu/entities/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum EquipRarity { common, rare, epic, legendary }

extension EquipRarityExtension on EquipRarity {
  int get order {
    switch (this) {
      case EquipRarity.common:
        return 0;
      case EquipRarity.rare:
        return 1;
      case EquipRarity.epic:
        return 2;
      case EquipRarity.legendary:
        return 3;
      default:
        return 0;
    }
  }
}

enum EquipType { head, body, legs, weapon }

extension EquipTypeExtension on EquipType {
  int get order {
    switch (this) {
      case EquipType.head:
        return 0;
      case EquipType.body:
        return 1;
      case EquipType.legs:
        return 2;
      case EquipType.weapon:
        return 3;
      default:
        return 0;
    }
  }
}

Player player = Player();

class Equipment {
  final int id;
  final String name;
  final String desc;
  final int price;
  final EquipRarity rarity;
  final int requiredLevel;
  final EquipType type;
  late DateTime? obtainedDate;
  final double? healthBonus;
  final double? armorBonus;
  final double? tapAttackBonus;
  final double? passiveAttackBonus;
  final double? tapRegenBonus;
  final double? passiveRegenBonus;
  final double? criticalChanceBonus;
  final double? criticalMultiplierBonus;

  static Map<Equipment, bool> shopEquipments = {};

  Equipment({
    required this.id,
    required this.name,
    required this.desc,
    required this.price,
    required this.rarity,
    required this.requiredLevel,
    required this.type,
    this.obtainedDate,
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
      requiredLevel: json["requiredLevel"],
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
          requiredLevel: 0,
          type: EquipType.weapon),
      growable: true);

  static Equipment getEquipmentById(int id) {
    return equipmentList.firstWhere((equip) => equip.id == id);
  }

  Map<String, double> getGivenStats() {
    Map<String, double> map = {};
    List<MapEntry<String, double>> entries = [
      MapEntry("healthBonus", healthBonus ?? 0.0),
      MapEntry("armorBonus", armorBonus ?? 0.0),
      MapEntry("tapAttackBonus", tapAttackBonus ?? 0.0),
      MapEntry("passiveAttackBonus", passiveAttackBonus ?? 0.0),
      MapEntry("tapRegenBonus", tapRegenBonus ?? 0.0),
      MapEntry("passiveRegenBonus", passiveRegenBonus ?? 0.0),
      MapEntry("criticalChanceBonus", criticalChanceBonus ?? 0.0),
      MapEntry("criticalMultiplierBonus", criticalMultiplierBonus ?? 0.0),
    ];
    entries.where((entry) => entry.value != 0.0).forEach((entry) {
      map[entry.key] = entry.value;
    });
    return map;
  }

  static List<String> getBonusLocalization(
      BuildContext context, String variableName) {
    switch (variableName) {
      case 'healthBonus':
        return [AppLocalizations.of(context)!.healthBonus, "+"];
      case 'armorBonus':
        return [AppLocalizations.of(context)!.armorBonus, "+"];
      case 'tapAttackBonus':
        return [AppLocalizations.of(context)!.tapAttackBonus, "+"];
      case 'passiveAttackBonus':
        return [AppLocalizations.of(context)!.passiveAttackBonus, "+"];
      case 'tapRegenBonus':
        return [AppLocalizations.of(context)!.tapRegenBonus, "%"];
      case 'passiveRegenBonus':
        return [AppLocalizations.of(context)!.passiveRegenBonus, "%"];
      case 'criticalChanceBonus':
        return [AppLocalizations.of(context)!.criticalChanceBonus, "%"];
      case 'criticalMultiplierBonus':
        return [AppLocalizations.of(context)!.criticalMultiplierBonus, "%"];
      default:
        throw ArgumentError("Invalid variable name: $variableName");
    }
  }

  static String getTypeLocalization(BuildContext context, EquipType type) {
    switch (type) {
      case EquipType.head:
        return AppLocalizations.of(context)!.head;
      case EquipType.body:
        return AppLocalizations.of(context)!.body;
      case EquipType.legs:
        return AppLocalizations.of(context)!.legs;
      case EquipType.weapon:
        return AppLocalizations.of(context)!.weapon;
      default:
        throw ArgumentError("Invalid EquipType: $type");
    }
  }

  static String getRarityLocalization(
      BuildContext context, EquipRarity rarity) {
    switch (rarity) {
      case EquipRarity.common:
        return AppLocalizations.of(context)!.common;
      case EquipRarity.rare:
        return AppLocalizations.of(context)!.rare;
      case EquipRarity.epic:
        return AppLocalizations.of(context)!.epic;
      case EquipRarity.legendary:
        return AppLocalizations.of(context)!.legendary;
      default:
        throw ArgumentError("Invalid EquipRarity: $rarity");
    }
  }

  String typeToString() {
    return type.toString().split('.').last;
  }

  static String typeArgToString(EquipType type) {
    return type.toString().split('.').last;
  }

  Equipment setObtainedDate(DateTime date) {
    obtainedDate = date;
    return this;
  }

  static Future<void> setupEquipments() async {
    await readEquipmentJson();
    generateShopEquipment();
  }

  static Future<void> readEquipmentJson() async {
    final String response = await rootBundle
        .loadString('assets/equipments/equipments_${player.locale}.json');
    final List data = await json.decode(response);
    equipmentList = data.map((json) => Equipment.fromJson(json)).toList();
  }

  static generateShopEquipment() {
    shopEquipments = {
      getEquipmentById(1): false,
      getEquipmentById(2): false,
      getEquipmentById(3): false,
      getEquipmentById(4): false,
    };
  }
}
