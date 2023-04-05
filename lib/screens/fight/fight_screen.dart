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

  final Map<int, AnimationController> _animationControllers = {};

  late AnimationController _imageAnimationController;
  late Animation<double> _imageAnimation;

  Map<int, Timer> animTimers = {};

  bool enemyTookDamage = false;
  double enemyDims = 200;

  @override
  void initState() {
    super.initState();

    player.floor = 1;
    enemy.newEnemy(player.gameMode, player.gameModesFloor[player.gameMode], 1);

    _imageAnimationController = AnimationController(
      duration: const Duration(milliseconds: 75),
      vsync: this,
    );

    _imageAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _imageAnimationController,
        curve: Curves.easeInOut,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _imageAnimationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _imageAnimationController.stop();
        }
      });
  }

  @override
  void dispose() {
    animTimers.forEach((key, value) {
      value.cancel();
    });
    _animationControllers.forEach((key, value) {
      value.dispose();
    });
    _imageAnimationController.dispose();
    super.dispose();
  }

  final GlobalKey _stackKey = GlobalKey();

  _onTapDown(TapDownDetails details, BuildContext context) {
    final playerDamage = player.attack();

    final id = DateTime.now().microsecondsSinceEpoch;
    _animationControllers[id] = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        upperBound: 1.0,
        lowerBound: 0.0);

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
          "-${playerDamage.round()}",
          style: playerDamage > player.getTapAttack()
              ? TextStyle(
                  color: Colors.yellow,
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  shadows: <Shadow>[
                      Shadow(
                          offset: const Offset(0, 0),
                          blurRadius: 3.0,
                          color: Colors.black.withOpacity(0.5))
                    ])
              : TextStyle(
                  color: Colors.red,
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  shadows: <Shadow>[
                      Shadow(
                          offset: const Offset(0, 0),
                          blurRadius: 3.0,
                          color: Colors.black.withOpacity(0.5))
                    ]),
        ),
      ),
    );

    setState(() {
      player.stats[3]++;
      if (enemy.health <= 1) {
        player.stats[2] =
            (player.stats[2] + 1.0);
      }
      player.stats[6] =
          player.stats[3] * player.tapAttack;

      enemyTookDamage = true;

      enemy.loseHealth(playerDamage);
      tapEffectsWidgets.add(widget);
    });

    _imageAnimationController.forward();
    _animationControllers[id]!.forward();

    animTimers[id] = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        enemyTookDamage = false;
        tapEffectsWidgets.remove(widget);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SnappingSheet(
        grabbingHeight: 50,
        grabbing: const UpgradesGrab(),
        sheetBelow: SnappingSheetContent(child: const UpgradesScreen()),
        child: Column(
          children: [
            AppBar(
              backgroundColor: Style.primaryColor,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () =>
                  selectedIndex.value = 0
              ),
              title: Text(
                  "${AppLocalizations.of(context)!.floor} ${player.gameModesFloor[player.gameMode]} • ${AppLocalizations.of(context)!.step} ${player.floor}/10",
                  textAlign: TextAlign.center,
                  style: Style.fightFloor),
              centerTitle: true,
            ),
            Expanded(
              child: GestureDetector(
                onTapDown: (TapDownDetails details) => _onTapDown(details, context),
                behavior: HitTestBehavior.opaque,
                child: Stack(
                  key: _stackKey,
                  children: <Widget>[
                        PlayerExpBar(
                            value: player.experience / player.nextLevelExp),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              // TODO: à changer par un scale pour ne pas bouger les autres widgets autour
                              Text(enemy.name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: (enemy.type == EnemyType.common)
                                          ? 20
                                          : 30)),
                              const SizedBox(height: 10),
                              EnemyHealthBar(
                                  value: enemy.health / enemy.maxHealth),
                              const SizedBox(height: 10),
                              Text("${enemy.health}/${enemy.maxHealth}"),
                              const SizedBox(height: 10),
                              AnimatedBuilder(
                                  animation: _imageAnimation,
                                  builder:
                                      (BuildContext context, Widget? child) {
                                    return Transform.scale(
                                      scale: _imageAnimation.value,
                                      child: child,
                                    );
                                  },
                                  child: SizedBox(
                                    width: enemyDims,
                                    height: enemyDims,
                                    child: Image.asset(
                                      "assets/enemies/images/${enemy.id}.png",
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return const ColoredBox(
                                            color: Colors.purple);
                                      },
                                    ),
                                  )),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("${player.getTapAttack()} dpc"),
                                  Text("${player.getPassiveAttack()} dps"),
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
          ],
        ));
  }
}

class EnemyHealthBar extends StatelessWidget {
  const EnemyHealthBar({super.key, required this.value});

  final double value;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: LinearProgressIndicator(
        minHeight: 8,
        value: value,
        color: Colors.red,
        semanticsLabel: 'Enemy health bar',
      ),
    );
  }
}

class PlayerExpBar extends StatelessWidget {
  const PlayerExpBar({super.key, required this.value});

  final double value;

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      minHeight: 8,
      value: value,
      color: Colors.blue,
      semanticsLabel: 'Player experience bar',
    );
  }
}
