
import 'package:flutter/material.dart';

class EquipmentSlot extends StatefulWidget {
  const EquipmentSlot({super.key});

  @override
  State<EquipmentSlot> createState() => _EquipmentSlotState();
}

class _EquipmentSlotState extends State<EquipmentSlot> {
  bool _isModalOpen = false;

  void _handleTap() {
    setState(() {
      _isModalOpen = true;
    });

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Dialogue'),
          content: Text('blabla'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _handleModalClose();
              },
              child: Text('OK'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _handleModalClose();
              },
              child: Text('Annuler'),
            ),
          ],
        );
      },
    );
  }

  void _handleModalClose() {
    setState(() {
      _isModalOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.0,
      height: 100.0,
      child: GestureDetector(
        onTap: _handleTap,
        child: Card(
          child: IconButton(
            icon: const Icon(Icons.add),
            onPressed: _handleTap,
          ),
        ),
      ),
    );
  }
}