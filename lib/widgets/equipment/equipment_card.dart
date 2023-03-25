import 'package:amaterasu/entities/player.dart';
import 'package:flutter/material.dart';

Player player = Player();

class EquipmentCard extends StatefulWidget {
  final int id;
  final String name;
  final String imagePath;
  final int price;

  const EquipmentCard(
      {super.key,
      required this.id,
      required this.name,
      this.imagePath = "assets/equipments/images/1.png",
      required this.price});

  @override
  State<EquipmentCard> createState() => _EquipmentCardState();
}

class _EquipmentCardState extends State<EquipmentCard> {
  bool _isOutOfStock = false;

  void _buyEquipment() {
    if (!_isOutOfStock) {
      if (player.money >= widget.price) {
        player.giveEquipmentById(widget.id);
        player.spendMoney(widget.price);
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
      child: Card(
        child: SizedBox(
          height: 200,
          width: 150,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: _isOutOfStock
                ? [const Text('OUT OF STOCK')]
                : [
                    Image.asset(widget.imagePath),
                    Text(widget.name),
                    Text('\$${widget.price}'),
                  ],
          ),
        ),
      ),
    );
  }
}