import 'package:amaterasu/entities/equipment.dart';
import 'package:amaterasu/entities/player.dart';
import 'package:amaterasu/widgets/equipment/equipment_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Player player = Player();

class EquipmentCard extends StatefulWidget {
  final Equipment equipment;
  final int id;
  final String name;
  final String imagePath;
  final int price;
  final EquipRarity rarity;

  const EquipmentCard(
      {super.key,
      required this.equipment,
      required this.id,
      required this.name,
      this.imagePath = "assets/equipments/images/1.png",
      required this.price,
      required this.rarity});

  @override
  State<EquipmentCard> createState() => _EquipmentCardState();
}

class _EquipmentCardState extends State<EquipmentCard> {
  bool _isOutOfStock = false;

  List rarityColors = [
    Colors.brown[300],
    Colors.blue[400],
    Colors.purple[300],
    Colors.orange[300]
  ];

  void _buyEquipment() {
    if (!_isOutOfStock && Equipment.shopEquipments[widget.equipment] == false) {
      if (player.money >= widget.price) {
        player.giveEquipmentById(widget.id);
        player.spendMoney(widget.price);
        Equipment.shopEquipments[widget.equipment] = true;
        setState(() {
          _isOutOfStock = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: _buyEquipment,
        child: SizedBox(
          width: 150,
          height: 200,
          child: Card(
            color: rarityColors[widget.rarity.index],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: (_isOutOfStock ||
                        Equipment.shopEquipments[widget.equipment] == true)
                    ? [
                        Text(
                            (AppLocalizations.of(context)!.outOfStock)
                                .toUpperCase(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                      ]
                    : [
                        EquipmentIcon(
                            equipment: widget.equipment, blackBorders: true),
                        const SizedBox(height: 5),
                        Text(widget.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            softWrap: true,
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.center),
                        const SizedBox(height: 5),
                        Text(
                            '${widget.price} ${AppLocalizations.of(context)!.goldsLower}'),
                      ],
              ),
            ),
          ),
        ));
  }
}
