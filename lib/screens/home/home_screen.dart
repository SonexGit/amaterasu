import 'package:amaterasu/entities/player.dart';
import 'package:amaterasu/utils/style.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Player player = Player();
final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showTutorial = true; // affiche la pop-up au début
  final List<Map<String, String>> tutorialPages = [
    {
      'title': 'Bienvenue dans Amaterasu_Clicker !',
      'content':
          'Clicker est un jeu simple mais addictif conçu par Allan VANNIER et Lucas RENARD. Profitez de ce jeu amusant et chronophage',
    },
    {
      'title': 'Comment gagner',
      'content':
          'Une fois que vous avez commencé, vous verrez un monstre avec un certains nombre de point de vie.\nLe but du jeu est de cliquer sur l\'écran le plus de fois possible pour tuer un maximum de monstre. Vous pouvez améliorer vos capacités d\'attaques',
    },
    {
      'title': 'Amusez-vous bien !',
      'content':
          'Ce jeu est fait pour faire passer le temps et de vous amuser un maximum',
    }
  ];
  int currentPage = 0;
  @override
  void initState() {
    super.initState();
    // affiche la pop-up au début
    Future.delayed(Duration.zero, () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(tutorialPages[currentPage]['title']!),
            content: Text(tutorialPages[currentPage]['content']!),
            actions: [
              TextButton(
                child: const Text('Suivant'),
                onPressed: () {
                  if (currentPage < tutorialPages.length) {
                    setState(() {
                      currentPage++;
                    });
                    Navigator.of(context).pop();
                    Future.delayed(Duration.zero, () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(tutorialPages[currentPage]['title']!),
                            content:
                                Text(tutorialPages[currentPage]['content']!),
                            actions: [
                              TextButton(
                                child: const Text('Suivant'),
                                onPressed: () {
                                  if (currentPage < tutorialPages.length - 1) {
                                    setState(() {
                                      currentPage++;
                                    });
                                    Navigator.of(context).pop();
                                    Future.delayed(Duration.zero, () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(
                                                tutorialPages[currentPage]
                                                    ['title']!),
                                            content: Text(
                                                tutorialPages[currentPage]
                                                    ['content']!),
                                            actions: [
                                              TextButton(
                                                child: const Text('Suivant'),
                                                onPressed: () {
                                                  if (currentPage <
                                                      tutorialPages.length -
                                                          1) {
                                                    setState(() {
                                                      currentPage++;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      showTutorial = true;
                                                    });
                                                  }
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    });
                                  } else {
                                    setState(() {
                                      showTutorial = true;
                                    });
                                    Navigator.of(context).pop();
                                    Future.delayed(Duration.zero, () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(
                                                tutorialPages[currentPage]
                                                    ['title']!),
                                            content: Text(
                                                tutorialPages[currentPage]
                                                    ['content']!),
                                            actions: [
                                              TextButton(
                                                child: const Text('Suivant'),
                                                onPressed: () {
                                                  if (currentPage <
                                                      tutorialPages.length -
                                                          1) {
                                                    setState(() {
                                                      currentPage++;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      showTutorial = true;
                                                    });
                                                  }
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    });
                                  }
                                },
                              ),
                            ],
                          );
                        },
                      );
                    });
                  } else {
                    setState(() {
                      showTutorial = false;
                    });
                  }
                },
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Column(
            children: [
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
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            "${AppLocalizations.of(context)!.afkIncome} 2416 ${AppLocalizations.of(context)!.goldsLower}",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ],
                    ),
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 400.0,
                      ),
                      items: imgList
                          .map(
                            (item) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                              ),
                              child: Center(
                                child: Image.network(
                                  item,
                                  fit: BoxFit.cover,
                                  width: 1000,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
