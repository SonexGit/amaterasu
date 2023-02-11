import 'package:amaterasu/entities/enemy.dart';
import 'package:amaterasu/entities/player.dart';
import 'package:amaterasu/screens/shop/shop_screen.dart';
import 'package:flutter/material.dart';
import 'package:amaterasu/utils/style.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

class FightScreen extends StatefulWidget {
  const FightScreen({super.key});

  @override
  State<FightScreen> createState() => _FightScreenState();
}

class _FightScreenState extends State<FightScreen> {
  Player player = Player();
  Enemy enemy = Enemy();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Style.whiteColor,
        body: SnappingSheet(
            grabbingHeight: 50,
            grabbing: const ShopGrab(),
            sheetBelow: SnappingSheetContent(child: const ShopScreen()),
            child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  setState(() {
                    enemy.loseHealth(player.tapAttack);
                  });
                },
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text("Étape ${player.storyFloor}"),
                        Text(enemy.name),
                        EnemyHealthBar(value: enemy.health / enemy.maxHealth),
                        const Text("ImageMéchant"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${player.tapAttack} dpc"),
                            Text("${player.passiveAttack} dps"),
                          ],
                        )
                      ],
                    )))));
  }
}

class EnemyHealthBar extends StatelessWidget {
  const EnemyHealthBar({super.key, required this.value});

  final double value;

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: value,
      color: Colors.red,
      semanticsLabel: 'Enemy health bar',
    );
  }
}
