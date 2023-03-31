import 'package:amaterasu/entities/equipment.dart';
import 'package:amaterasu/entities/player.dart';
import 'package:amaterasu/widgets/equipment/equipment_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EquipmentSlot extends StatefulWidget {
  final String type;
  const EquipmentSlot({Key? key, required this.type}) : super(key: key);

  @override
  State<EquipmentSlot> createState() => _EquipmentSlotState();
}

class _EquipmentSlotState extends State<EquipmentSlot> {
  Player player = Player();

  bool _isModalOpen = false;
  Equipment? _selectedEquipment;
  EquipType? type;
  Widget? equipmentIcon;

  List<Equipment> filteredInventory = [];

  Color? svgColor;

  @override
  void initState() {
    super.initState();
    type = EquipType.values
        .firstWhere((type) => type.toString().split('.')[1] == widget.type);
    _selectedEquipment = player.equipments[Equipment.typeArgToString(type!)];

    double svgSize = 30.0;
    svgColor = Colors.grey[800];

    switch (Equipment.typeArgToString(type!)) {
      case "head":
        equipmentIcon = SvgPicture.asset("assets/equipments/icons/head.svg",
            width: svgSize, height: svgSize, color: svgColor);
        break;
      case "body":
        equipmentIcon = SvgPicture.asset("assets/equipments/icons/body.svg",
            width: svgSize, height: svgSize, color: svgColor);
        break;
      case "legs":
        equipmentIcon = SvgPicture.asset("assets/equipments/icons/legs.svg",
            width: svgSize, height: svgSize, color: svgColor);
        break;
      case "weapon":
        equipmentIcon = SvgPicture.asset("assets/equipments/icons/weapon.svg",
            width: svgSize, height: svgSize, color: svgColor);
        break;
      default:
        equipmentIcon =
            Container(); // Définir un SVG par défaut ou un container vide
    }
  }

  void _handleTap() {
    filteredInventory =
        player.inventory.where((equipment) => equipment.type == type).toList();

    setState(() {
      _isModalOpen = true;
    });

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.pickEquipment(
              Equipment.getTypeLocalization(context, type!).toLowerCase())),
          content: SizedBox(
            height: 300,
            width: 200,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
              ),
              itemBuilder: (context, index) {
                Equipment equipment = filteredInventory[index];
                return GridTile(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isModalOpen = false;
                        _selectedEquipment = equipment;
                        player.equip(equipment);
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(4.0),
                      color: Colors.grey[300],
                      child: Center(
                        child: EquipmentIcon(equipment: equipment),
                      ),
                    ),
                  ),
                );
              },
              itemCount: filteredInventory.length,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            equipmentIcon!,
            const SizedBox(width: 10),
            Text(
              Equipment.getTypeLocalization(context, type!).toUpperCase(),
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold, color: svgColor),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
            width: 100.0,
            height: 100.0,
            child: GestureDetector(
              onTap: _handleTap,
              child: Card(
                child: _selectedEquipment != null
                    ? EquipmentIcon(equipment: _selectedEquipment!)
                    : IconButton(
                        icon: const Icon(Icons.add, size: 40),
                        onPressed: _handleTap,
                      ),
              ),
            ))
      ],
    );
  }
}
