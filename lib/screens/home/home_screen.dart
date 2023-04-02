import 'package:amaterasu/entities/player.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:async';

import 'package:lottie/lottie.dart';

Player player = Player();
final List<String> txtList = [
  'Le Saviez vous! Vous pouvez voir le descriptif de chaque équipements en maintenant le doigt sur l\'équipement de votre choix.',
  'Le Profil permet de voir chaque statistiques du joueur',
  'Des nouvelles quêtes chaque jour pour vous donner encore plus envie de jouer'
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> tutorialPages = [
    {
      'title': 'Bienvenue dans Amaterasu !',
      'content':
          'C\'est un jeu simple mais addictif conçu par Allan VANNIER et Lucas RENARD. Profitez de ce jeu amusant et chronophage',
    },
    {
      'title': 'Comment gagner',
      'content':
          'Une fois que vous avez commencé, vous combattrez un monstre avec un certain nombre de point de vie.\nLe but du jeu est de cliquer sur l\'écran le plus de fois possible pour tuer un maximum de monstre. Vous pouvez améliorer vos capacités d\'attaques',
    },
    {
      'title': 'Amusez-vous bien !',
      'content':
          'Ce jeu est fait pour faire passer le temps tout en s\'amusant un maximum',
    }
  ];

  int currentPage = 0;
  bool showTutorial = !player.haveSeenTutorial;

  @override
  void initState() {
    super.initState();

    // affiche la pop-up au début
    if (showTutorial) {
      player.haveSeenTutorial = true;
      Future.delayed(Duration.zero, () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: Text(tutorialPages[currentPage]['title']!),
                  content: Text(tutorialPages[currentPage]['content']!),
                  actions: [
                    TextButton(
                      child: const Text('Suivant'),
                      onPressed: () {
                        if (currentPage < tutorialPages.length - 1 &&
                            showTutorial == true) {
                          setState(() {
                            currentPage++;
                          });
                        } else {
                          setState(() {
                            player.haveSeenTutorial = true;
                          });
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ],
                );
              },
            );
          },
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 30,
              horizontal: 20,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "${AppLocalizations.of(context)!.hello} ${player.name}",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 5),
                player.lastAfkIncome != 0
                    ? Row(
                        children: [
                          Flexible(
                            child: Text(
                              "${AppLocalizations.of(context)!.afkIncome} ${player.lastAfkIncome} ${AppLocalizations.of(context)!.goldsLower}",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(),
                CarouselSlider.builder(
                  itemCount: txtList.length,
                  itemBuilder:
                      (BuildContext context, int index, int realIndex) {
                    final text = txtList[index];
                    return Container(
                      color: Colors.grey,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.lightbulb_outline_rounded,
                              size: 26,
                              color: Colors.yellow,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              text,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: 100,
                    aspectRatio: 1.0,
                    viewportFraction: 0.9,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 600),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                Align(
                  child: Lottie.asset(
                    'assets/lottie/animation.json',
                    height: 500,
                    width: 350,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
        ])));
  }
}
