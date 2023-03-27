import 'dart:async';

import 'package:amaterasu/entities/enemy.dart';
import 'package:amaterasu/entities/player.dart';
import 'package:amaterasu/screens/adventure/adventure_screen.dart';
import 'package:amaterasu/screens/upgrades/upgrades_screen.dart';
import 'package:flutter/material.dart';
import 'package:amaterasu/utils/style.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FightScreen extends StatefulWidget {
  const FightScreen({super.key});

  @override
  State<FightScreen> createState() => _FightScreenState();
}

class _FightScreenState extends State<FightScreen>
    with TickerProviderStateMixin {
  Player player = Player();
  Enemy enemy = Enemy();

  final tapEffectsWidgets = <Widget>[];
  final List<double> _widgetOpacity = List.empty(growable: true);

  final Map<int, AnimationController> _animationControllers = {};

  @override
  void initState() {
    super.initState();
    player.floor = 1;
    enemy.newEnemy(player.gameMode, player.gameModesFloor[player.gameMode], 1);
  }

  final GlobalKey _stackKey = GlobalKey();

  _onTapDown(TapDownDetails details) {
    final id = DateTime.now().microsecondsSinceEpoch;
    _animationControllers[id] = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      upperBound: 1.0,
      lowerBound: 0.0
    );

    final RenderBox box =
        _stackKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = box.globalToLocal(details.globalPosition);

    final widget = Positioned(
      top: offset.dy - 50,
      left: offset.dx,
      child: AnimatedBuilder(
        animation: _animationControllers[id]!,
        builder: (context, child) {
          final animation = CurvedAnimation(
            parent: _animationControllers[id]!,
            curve: Curves.easeOut.flipped,
          );
          return Opacity(
            opacity: 1 - animation.value,
            child: child,
          );
        },
        child: Text(
          "-${player.getDamagePerTap().round()}",
          style: const TextStyle(
            color: Colors.red,
            fontSize: 26.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    setState(() {
      player.stats["Clic"] = (player.stats["Clic"]! + 1.0);
      if (enemy.health <= 1) {
        player.stats["Monstres battus"] =
            (player.stats["Monstres battus"]! + 1.0);
      }
      player.stats["Dégats infligés"] =
          player.stats["Clic"]! * player.tapAttack;
      enemy.loseHealth(player.getDamagePerTap());

      tapEffectsWidgets.add(widget);
      _widgetOpacity.add(1.0);
    });

    _animationControllers[id]!.forward();

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        tapEffectsWidgets.remove(widget);
        _widgetOpacity.removeAt(0);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.whiteColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => selectedIndex.value = 0,
        ),
        title: Text(
          "${AppLocalizations.of(context)!.floor} ${player.gameModesFloor[player.gameMode]} • ${AppLocalizations.of(context)!.step} ${player.floor}/10",
          textAlign: TextAlign.center,
        ),
      ),
      body: SnappingSheet(
        grabbingHeight: 50,
        grabbing: const UpgradesGrab(),
        sheetBelow: SnappingSheetContent(child: const UpgradesScreen()),
        child: GestureDetector(
          onTapDown: (TapDownDetails details) => _onTapDown(details),
          behavior: HitTestBehavior.opaque,
          child: Stack(
            key: _stackKey,
            children: <Widget>[
                  // ignore: prefer_const_constructors
                  ColoredBox(
                    color: Colors.white,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(enemy.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                        const SizedBox(height: 5),
                        EnemyHealthBar(value: enemy.health / enemy.maxHealth),
                        const SizedBox(height: 5),
                        Text("${enemy.health}/${enemy.maxHealth}"),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 200,
                          height: 200,
                          child: Image.asset(
                            "assets/enemies/images/${enemy.id}.png",
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                              return const ColoredBox(color: Colors.purple);
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${player.tapAttack} dpc"),
                            Text("${player.passiveAttack} dps"),
                          ],
                        ),
                      ],
                    ),
                  )
                ] +
                tapEffectsWidgets,
          ),
        ),
      ),
    );
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
