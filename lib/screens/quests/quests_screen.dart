import 'package:amaterasu/entities/player.dart';
import 'package:amaterasu/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:audioplayers/audioplayers.dart';

class QuestsPage extends StatefulWidget {
  const QuestsPage({super.key});

  @override
  State<QuestsPage> createState() => _QuestsPageState();
}

class _QuestsPageState extends State<QuestsPage> {
  Player player = Player();

  @override
  void initState() {
    super.initState();

    player.setupQuests();
  }

  final playerAudio = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              AppLocalizations.of(context)!.dailyQuests,
              style: Style.questsHeadline,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: player.dailyQuestsFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final dailyQuests = snapshot.data!;
                  List<Widget> questWidgets = [];
                  int questGoal0 = dailyQuests[0]['goal']!.toInt();
                  int questProgress0 = player.stats[3].toInt();

                  int questGoal1 = dailyQuests[1]['goal']!.toInt();
                  int questProgress1 = player.attack().toInt();

                  int questGoal2 = dailyQuests[2]['goal']!.toInt();
                  int questProgress2 = player.stats[2].toInt();

                  bool isComplete0 = questProgress0 >= questGoal0;
                  bool isComplete1 = questProgress1 >= questGoal1;
                  bool isComplete2 = questProgress2 >= questGoal2;

                  questWidgets.add(
                    Column(
                      children: [
                        ListTile(
                          title: Text(dailyQuests[0]['title']),
                          subtitle:
                              Text('${AppLocalizations.of(context)!.reward} : ${dailyQuests[0]['reward']}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                onPressed: (isComplete0 == true) &&
                                        (player.isButtonClicked0 == false) &&
                                        (player.dailyQuestsStatus[0] == false)
                                    ? () {
                                        setState(() {
                                          player.giveMoney(
                                              dailyQuests[0]['reward']);
                                          isComplete0 = false;
                                          player.isButtonClicked0 = true;
                                          player.dailyQuestsStatus[0] = true;
                                          playerAudio
                                              .play(AssetSource('piece.mp3'));
                                        });
                                      }
                                    : null,
                                child: Text((isComplete0 == true) &&
                                        (player.isButtonClicked0 == false) &&
                                        (player.dailyQuestsStatus[0] == false)
                                    ? AppLocalizations.of(context)!.claim
                                    : '$questProgress0 / $questGoal0'),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: LinearProgressIndicator(
                            value: questProgress0 / questGoal0,
                            backgroundColor: Colors.grey[300],
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Style.primaryColor),
                          ),
                        ),
                      ],
                    ),
                  );
                  questWidgets.add(
                    Column(
                      children: [
                        ListTile(
                          title: Text(dailyQuests[1]['title']),
                          subtitle:
                              Text('${AppLocalizations.of(context)!.reward} : ${dailyQuests[1]['reward']}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                onPressed: (isComplete1 == true) &&
                                        (player.isButtonClicked1 == false) &&
                                        (player.dailyQuestsStatus[1] == false)
                                    ? () {
                                        setState(() {
                                          player.giveMoney(
                                              dailyQuests[1]['reward']);
                                          isComplete1 = false;
                                          player.isButtonClicked1 = true;
                                          player.dailyQuestsStatus[1] = true;
                                          playerAudio
                                              .play(AssetSource('piece.mp3'));
                                        });
                                      }
                                    : null,
                                child: Text((isComplete1 == true) &&
                                        (player.isButtonClicked1 == false) &&
                                        (player.dailyQuestsStatus[1] == false)
                                    ? AppLocalizations.of(context)!.claim
                                    : '$questProgress1 / $questGoal1'),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: LinearProgressIndicator(
                            value: questProgress1 / questGoal1,
                            backgroundColor: Colors.grey[300],
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Style.primaryColor),
                          ),
                        ),
                      ],
                    ),
                  );
                  questWidgets.add(
                    Column(
                      children: [
                        ListTile(
                          title: Text(dailyQuests[2]['title']),
                          subtitle:
                              Text('${AppLocalizations.of(context)!.reward} : ${dailyQuests[2]['reward']}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                onPressed: (isComplete2 == true) &&
                                        (player.isButtonClicked2 == false) &&
                                        (player.dailyQuestsStatus[2] == false)
                                    ? () {
                                        setState(() {
                                          player.giveMoney(
                                              dailyQuests[2]['reward']);
                                          isComplete2 = false;
                                          player.isButtonClicked2 = true;
                                          player.dailyQuestsStatus[2] = true;
                                          playerAudio
                                              .play(AssetSource('piece.mp3'));
                                        });
                                      }
                                    : null,
                                child: Text((isComplete2 == true) &&
                                        (player.isButtonClicked2 == false) &&
                                        (player.dailyQuestsStatus[2] == false)
                                    ? AppLocalizations.of(context)!.claim
                                    : '$questProgress2 / $questGoal2'),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: LinearProgressIndicator(
                            value: questProgress2 / questGoal2,
                            backgroundColor: Colors.grey[300],
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Style.primaryColor),
                          ),
                        ),
                      ],
                    ),
                  );

                  return Column(
                    children: [
                      Expanded(
                        child: ListView(children: questWidgets),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Erreur: ${snapshot.error}'),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              AppLocalizations.of(context)!.monthlyQuests,
              style: Style.questsHeadline,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: player.monthlyQuestsFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final monthlyQuests = snapshot.data!;
                  List<Widget> questWidgets = [];
                  int questMGoal0 = monthlyQuests[0]['goal']!.toInt();
                  int questMProgress0 = player.stats[3].toInt();

                  int questMGoal1 = monthlyQuests[1]['goal']!.toInt();
                  int questMProgress1 = player.attack().toInt();

                  int questMGoal2 = monthlyQuests[2]['goal']!.toInt();
                  int questMProgress2 = player.money.toInt();

                  bool isCompleteM0 = questMProgress0 >= questMGoal0;
                  bool isCompleteM1 = questMProgress1 >= questMGoal1;
                  bool isCompleteM2 = questMProgress2 >= questMGoal2;

                  questWidgets.add(
                    Column(
                      children: [
                        ListTile(
                          title: Text(monthlyQuests[0]['title']),
                          subtitle:
                              Text('${AppLocalizations.of(context)!.reward} : ${monthlyQuests[0]['reward']}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                onPressed: (isCompleteM0 == true) &&
                                        (player.isButtonClickedM0 == false) &&
                                        (player.dailyQuestsStatus[0] == false)
                                    ? () {
                                        setState(() {
                                          player.giveMoney(
                                              monthlyQuests[0]['reward']);
                                          isCompleteM0 = false;
                                          player.isButtonClickedM0 = true;
                                          player.monthlyQuestsStatus[0] = true;
                                          playerAudio
                                              .play(AssetSource('piece.mp3'));
                                        });
                                      }
                                    : null,
                                child: Text((isCompleteM0 == true) &&
                                        (player.isButtonClickedM0 == false) &&
                                        (player.dailyQuestsStatus[0] == false)
                                    ? AppLocalizations.of(context)!.claim
                                    : '$questMProgress0 / $questMGoal0'),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: LinearProgressIndicator(
                            value: questMProgress0 / questMGoal0,
                            backgroundColor: Colors.grey[300],
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Style.primaryColor),
                          ),
                        ),
                      ],
                    ),
                  );
                  questWidgets.add(
                    Column(
                      children: [
                        ListTile(
                          title: Text(monthlyQuests[1]['title']),
                          subtitle:
                              Text('${AppLocalizations.of(context)!.reward} : ${monthlyQuests[1]['reward']}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                onPressed: (isCompleteM1 == true) &&
                                        (player.isButtonClickedM1 == false) &&
                                        (player.monthlyQuestsStatus[1] == false)
                                    ? () {
                                        setState(() {
                                          player.giveMoney(
                                              monthlyQuests[1]['reward']);
                                          isCompleteM1 = false;
                                          player.isButtonClickedM1 = true;
                                          player.dailyQuestsStatus[1] = true;
                                          playerAudio
                                              .play(AssetSource('piece.mp3'));
                                        });
                                      }
                                    : null,
                                child: Text((isCompleteM1 == true) &&
                                        (player.isButtonClickedM1 == false) &&
                                        (player.monthlyQuestsStatus[1] == false)
                                    ? AppLocalizations.of(context)!.claim
                                    : '$questMProgress1 / $questMGoal1'),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: LinearProgressIndicator(
                            value: questMProgress1 / questMGoal1,
                            backgroundColor: Colors.grey[300],
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Style.primaryColor),
                          ),
                        ),
                      ],
                    ),
                  );
                  questWidgets.add(
                    Column(
                      children: [
                        ListTile(
                          title: Text(monthlyQuests[2]['title']),
                          subtitle:
                              Text('${AppLocalizations.of(context)!.reward} : ${monthlyQuests[2]['reward']}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                onPressed: (isCompleteM2 == true) &&
                                        (player.isButtonClickedM2 == false) &&
                                        (player.monthlyQuestsStatus[2] == false)
                                    ? () {
                                        setState(() {
                                          player.giveMoney(
                                              monthlyQuests[2]['reward']);
                                          isCompleteM2 = false;
                                          player.isButtonClickedM2 = true;
                                          player.dailyQuestsStatus[2] = true;
                                          playerAudio
                                              .play(AssetSource('piece.mp3'));
                                        });
                                      }
                                    : null,
                                child: Text((isCompleteM2 == true) &&
                                        (player.isButtonClickedM2 == false) &&
                                        (player.monthlyQuestsStatus[2] == false)
                                    ? AppLocalizations.of(context)!.claim
                                    : '$questMProgress2 / $questMGoal2'),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: LinearProgressIndicator(
                            value: questMProgress2 / questMGoal2,
                            backgroundColor: Colors.grey[300],
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Style.primaryColor),
                          ),
                        ),
                      ],
                    ),
                  );
                  return Column(
                    children: [
                      Expanded(
                        child: ListView(children: questWidgets),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Erreur: ${snapshot.error}'),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
