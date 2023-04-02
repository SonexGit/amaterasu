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
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Équipements du jour",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
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
          ),
        ],
      ),
    );
  }
}
