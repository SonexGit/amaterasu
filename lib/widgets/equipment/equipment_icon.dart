import 'dart:math';

import 'package:amaterasu/entities/equipment.dart';
import 'package:flutter/material.dart';

class EquipmentIcon extends StatefulWidget {
  final Equipment equipment;
  final String imagePath;

  const EquipmentIcon(
      {super.key, required this.imagePath, required this.equipment});

  @override
  State<EquipmentIcon> createState() => _EquipmentIconState();
}

class _EquipmentIconState extends State<EquipmentIcon> {
  late OverlayEntry _overlayEntry;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (LongPressStartDetails details) {
        setState(() {
          _showOverlayAt(context, details.globalPosition);
        });
      },
      onLongPressUp: () {
        setState(() {
          _hideOverlay();
        });
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.asset(widget.imagePath),
          ],
        ),
      ),
    );
  }

  void _showOverlayAt(BuildContext context, Offset tapPosition) {
    const text = 'My overlay text'; // replace with your overlay text
    const textStyle = TextStyle(
        fontSize: 20,
        color: Colors.white); // replace with your overlay text style

    final textPainter = TextPainter(
      text: const TextSpan(text: text, style: textStyle),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(maxWidth: 300);

    final statsTexts = widget.equipment.getGivenStats().entries.map((entry) {
      if (entry.value != 0.0) {
        // ajouter seulement si différent de 0.0
        return Text("${entry.key}: ${entry.value}",
            style: const TextStyle(fontSize: 16));
      }
    }).toList();

    final statsColumn = Column(
      children: statsTexts.where((t) => t != null).toList(),
    );

    final overlaySize = Size(
        max(textPainter.width, statsColumn.width) + 16, // prendre le plus grand
        textPainter.height +
            statsColumn.height +
            24 // ajouter la hauteur de statsColumn
        );

    _overlayEntry = OverlayEntry(builder: (context) {
      final screenSize = MediaQuery.of(context).size;
      final left = tapPosition.dx - overlaySize.width;
      final top = tapPosition.dy - overlaySize.height + 60;

      return Positioned(
          left: left.clamp(20.0, screenSize.width - overlaySize.width),
          top: top.clamp(20.0, screenSize.height - overlaySize.height),
          child: Container(
              width: overlaySize.width,
              height: overlaySize.height,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                  children: [
                        Text(widget.equipment.name,
                            style: const TextStyle(fontSize: 16),
                            softWrap: true,
                            overflow: TextOverflow.visible),
                        Text(widget.equipment.rarity.toString(),
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 20),
                      ] +
                      widget.equipment.getGivenStats().entries.map((entry) {
                        return Text("${entry.key}: ${entry.value}",
                            style: const TextStyle(fontSize: 16));
                      }).toList())));
    });
    Overlay.of(context)?.insert(_overlayEntry);
  }

  void _hideOverlay() {
    _overlayEntry.remove();
  }
}
