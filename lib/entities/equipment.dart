import 'dart:convert';

import 'package:flutter/services.dart';

enum EquipRarity { common, rare, epic, legendary }

enum EquipType { head, body, legs, weapon }

class Equipment {
  int id = 0;
  String name = "";
  String desc = "";
  int price = 0;
  EquipRarity? rarity = EquipRarity.common;
  int requiredFloor = 0;
  EquipType? type;

  static List<Equipment> shopEquipments = [];

  Equipment(
      {required this.id,
      required this.name,
      required this.desc,
      required this.price,
      required this.rarity,
      required this.requiredFloor,
      this.type});

  factory Equipment.fromJson(Map<String, dynamic> json) {
    return Equipment(
      id: json["id"],
      name: json["name"],
      desc: json["desc"],
      price: json["price"],
      rarity: EquipRarity.values[json["rarity"]],
      requiredFloor: json["requiredFloor"],
      type: EquipType.values[json["type"]],
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

  static Future<void> setupEquipments() async {
    await readEquipmentJson();
    print(equipmentList);
    generateShopEquipment();
  }

  static Future<void> readEquipmentJson() async {
    final String response =
        await rootBundle.loadString('assets/equipments/equipments.json');
    final List data = await json.decode(response);
    print(data);
    equipmentList = data.map((json) => Equipment.fromJson(json)).toList();
    print("cc $equipmentList");
  }

  static generateShopEquipment() {
    shopEquipments = [
      getEquipmentById(1),
      getEquipmentById(2),
      getEquipmentById(3)
    ];
  }
}
