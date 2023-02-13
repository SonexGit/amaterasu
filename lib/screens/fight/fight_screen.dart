import 'dart:async';

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

  final tapEffectsWidgets = <Widget>[];
  // int widgetIndex = 0;
  // List<Timer>? _timer;
  // List<double>? _widgetOpacities;

  // void _reduceOpacityTapEffect(Timer timer) {
  //   setState(() {
  //     _widgetOpacities?[widgetIndex] += 0.05;
  //     if (_widgetOpacities![widgetIndex] >= 1.00) {
  //       _timer![widgetIndex].cancel();
  //     }
  //   });
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   for (var i = widgetIndex; i < 0; i--) {
  //     _timer![i].cancel();
  //   }
  // }

  _onTapDown(TapDownDetails details) {
    var effect = Positioned(
        left: details.localPosition.dx,
        top: details.localPosition.dy,
        child: const Text("-1"));

    setState(() {
      //   _widgetOpacities![widgetIndex] = 0.0;
      //   _timer![widgetIndex] = Timer.periodic(
      //       const Duration(milliseconds: 50), _reduceOpacityTapEffect);
      tapEffectsWidgets.add(effect);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Style.whiteColor,
        body: SnappingSheet(
            grabbingHeight: 50,
            grabbing: const ShopGrab(),
            sheetBelow: SnappingSheetContent(child: const ShopScreen()),
            child: GestureDetector(
                onTapDown: (TapDownDetails details) => _onTapDown(details),
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  setState(() {
                    enemy.loseHealth(player.tapAttack);
                  });
                },
                child: Stack(
                    children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 50.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text("Étape ${player.storyFloor}"),
                                Text(enemy.name),
                                EnemyHealthBar(
                                    value: enemy.health / enemy.maxHealth),
                                const Text("ImageMéchant"),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("${player.tapAttack} dpc"),
                                    Text("${player.passiveAttack} dps"),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ] +
                        tapEffectsWidgets))));
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
