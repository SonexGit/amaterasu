import 'package:amaterasu/entities/equipment.dart';
import 'package:amaterasu/widgets/equipment/equipment_card.dart';
import 'package:flutter/material.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 6.0,
      runSpacing: 8.0,
      children: Equipment.shopEquipments.keys
          .map((item) => EquipmentCard(
              equipment: item,
              id: item.id,
              name: item.name,
              price: item.price,
              rarity: item.rarity))
          .toList(),
    );
  }
}
