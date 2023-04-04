import 'package:amaterasu/entities/player.dart';
import 'package:amaterasu/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:carousel_slider/carousel_slider.dart';

class TutorialScreen extends StatefulWidget {
  final Function onTutorialClosed;

  const TutorialScreen({super.key, required this.onTutorialClosed});

  @override
  State<TutorialScreen> createState() => TutorialScreenState();

  void closeTutorial() {
    // Appeler la fonction de rappel onTutorialClosed
    onTutorialClosed();
  }
}

class TutorialScreenState extends State<TutorialScreen> {
  Player player = Player();

  final TextEditingController _textEditingController = TextEditingController();

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

  int _currentIndex = 0;
  bool isNameValid = false;
  final _formKey = GlobalKey<FormState>();

  void finishTutorial() {
    String name = _textEditingController.text;
    setState(() {
      player.name = name;
      player.haveSeenTutorial = true;
      widget.closeTutorial();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.secondaryColor,
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CarouselSlider(
            items: [
              for (int i = 0; i < tutorialPages.length; i++)
                Container(
                  color: Style.primaryColor,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(tutorialPages[i]['title']!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 20.0),
                          Text(
                            tutorialPages[i]['content']!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              Container(
                color: Style.primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 60.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.pickName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24),
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: _textEditingController,
                        validator: (value) {
                          if ((value?.trim().length ?? 0) < 3) {
                            return AppLocalizations.of(context)!.nameMinLength;
                          }
                          return null;
                        },
                        onChanged: (text) {
                          setState(() {
                            isNameValid = (text.trim().length >= 3);
                          });
                        },
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.insertName,
                          fillColor: Colors.white,
                          filled: true,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Style.secondaryColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25.0, vertical: 16.0)),
                      onPressed: () => _formKey.currentState!.validate()
                          ? finishTutorial()
                          : null,
                      child: Text(AppLocalizations.of(context)!.play,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ],
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.95,
              viewportFraction: 1.0,
              onPageChanged: (index, _) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < tutorialPages.length + 1; i++)
                Container(
                  width: 12,
                  height: MediaQuery.of(context).size.height * 0.05,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == i ? Colors.white : Colors.grey,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
