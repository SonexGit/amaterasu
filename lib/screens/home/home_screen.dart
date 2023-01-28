import 'package:amaterasu/entities/player.dart';
import 'package:amaterasu/utils/style.dart';
import 'package:flutter/material.dart';

Player player = Player();

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Style.whiteColor,
        body: ListView(
          children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 30, horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Bonjour ${player.name}",
                              style: Style.headlineStyleHome),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                                "Pendant que vous n'étiez pas la, vous avez gagné un total de 2416 pièces d'or",
                                style: Style.sublineStyleHome),
                          )
                        ],
                      ),
                      Row()
                    ],
                  )
                ),
              ],
            )
          ],
        ));
  }
}