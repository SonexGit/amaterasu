import 'dart:math';

import 'package:amaterasu/entities/equipment.dart';
import 'package:amaterasu/utils/style.dart';
import 'package:flutter/material.dart';

class EquipmentIcon extends StatefulWidget {
  final Equipment equipment;
  final String? imagePath;
  final bool? blackBorders;

  const EquipmentIcon({super.key, this.imagePath, required this.equipment, this.blackBorders = false});

  @override
  State<EquipmentIcon> createState() => _EquipmentIconState();
}

class _EquipmentIconState extends State<EquipmentIcon> {
  late OverlayEntry _overlayEntry;

  List rarityColors = [
    Colors.brown[300],
    Colors.blue[400],
    Colors.purple[300],
    Colors.orange[300]
  ];

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
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(
              color: widget.blackBorders! ? Colors.black : rarityColors[widget.equipment.rarity.index],
              width: 2,
            )),
            child: Image.asset(widget.imagePath ??
                "assets/equipments/images/${widget.equipment.id}.png"),
          ),
        ],
      ),
    );
  }

  void _showOverlayAt(BuildContext context, Offset tapPosition) {
    var text = widget.equipment.name; // replace with your overlay text
    const textStyle = TextStyle(
        fontSize: 16,
        color: Colors.black,
        decoration:
            TextDecoration.none); // replace with your overlay text style

    final textPainter = TextPainter(
      text: TextSpan(text: text, style: textStyle),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
    )..layout(minWidth: 250);

    final statsTexts = widget.equipment.getGivenStats().entries.map((entry) {
      String textContent = (Equipment.getLocalization(context, entry.key)[1] ==
              "+")
          ? "${Equipment.getLocalization(context, entry.key)[0]}: +${entry.value == (entry.value).toInt() ? (entry.value.toInt()).toString() : (entry.value).toString()}"
          : "${Equipment.getLocalization(context, entry.key)[0]}: +${entry.value * 100}%";

      if (entry.value != 0.0) {
        // ajouter seulement si différent de 0.0
        return Text(textContent,
            textAlign: TextAlign.start,
            style: Style.fontFamily.merge(const TextStyle(
              fontSize: 16,
              color: Colors.black,
              decoration: TextDecoration.none,
            )));
      }
    }).toList();

    final statsColumn =
        statsTexts.where((t) => t != null).map((t) => t!).toList();

    final overlaySize = Size(max(textPainter.width, 250) + 40 + 4,
        textPainter.height + 35 + 22 * statsTexts.length + 20 + 10 + 4);

    _overlayEntry = OverlayEntry(builder: (context) {
      final screenSize = MediaQuery.of(context).size;
      final left = tapPosition.dx - overlaySize.width;
      final top = tapPosition.dy + overlaySize.height / 4;

      return Positioned(
        left: left.clamp(20.0, screenSize.width - overlaySize.width),
        top: top.clamp(20.0, screenSize.height - overlaySize.height),
        child: Container(
            width: overlaySize.width,
            height: overlaySize.height,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(
                color: rarityColors[widget.equipment.rarity.index],
                width: 2,
              ),
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                      Text(widget.equipment.name,
                          style: Style.fontFamily.merge(const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                              decoration: TextDecoration.none))),
                      Text(widget.equipment.rarity.toString(),
                          style: Style.fontFamily.merge(TextStyle(
                              fontSize: 16,
                              color:
                                  rarityColors[widget.equipment.rarity.index],
                              decoration: TextDecoration.none))),
                      const SizedBox(height: 20)
                    ] +
                    statsColumn)),
      );
    });
    Overlay.of(context).insert(_overlayEntry);
  }

  void _hideOverlay() {
    _overlayEntry.remove();
  }
}
