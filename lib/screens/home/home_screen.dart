import 'package:amaterasu/entities/player.dart';
import 'package:amaterasu/utils/style.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:async';

import 'package:lottie/lottie.dart';

Player player = Player();
final List<String> txtList = [
  'Vous pouvez voir le descriptif d\'un équipement en maintenant votre doigt sur l\'icône d\'un l\'équipement',
  'Le Profil permet de voir toutes les statistiques du joueur comme l\'entièreté des dégâts infligés',
  'Jouez au jeu tous les jours pour avoir de nouvelles quêtes journalières'
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
                        style: Style.headlineStyleHome)
                  ],
                ),
                const SizedBox(height: 5),
                player.lastAfkIncome != 0
                    ? Row(
                        children: [
                          Flexible(
                            child: Text(
                                "${AppLocalizations.of(context)!.afkIncome} ${player.lastAfkIncome} ${AppLocalizations.of(context)!.goldsLower}",
                                style: Style.sublineStyleHome),
                          ),
                        ],
                      )
                    : Container(),
                Align(
                  child: Lottie.asset(
                    'assets/lottie/animation.json',
                    fit: BoxFit.fill,
                    alignment: Alignment.bottomCenter,
                  ),
                ),
                CarouselSlider.builder(
                  itemCount: txtList.length,
                  itemBuilder:
                      (BuildContext context, int index, int realIndex) {
                    final text = txtList[index];
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        decoration: BoxDecoration(
                            color: Style.primaryColor,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 0,
                                blurRadius: 10,
                              ),
                            ]),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.lightbulb_outline_rounded,
                                size: 40,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                text,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: 170,
                    aspectRatio: 1.0,
                    viewportFraction: 1,
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
              ],
            ),
          ),
        ])));
  }
}
