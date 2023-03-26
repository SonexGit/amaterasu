import 'dart:convert';
import 'package:amaterasu/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QuestsPage extends StatefulWidget {
  @override
  _QuestsPageState createState() => _QuestsPageState();
}

class _QuestsPageState extends State<QuestsPage> {
  bool _isButtonEnabled0 = false;
  bool _isButtonEnabled1 = false;
  bool _isButtonEnabled2 = false;
  late Future<List<Map<String, dynamic>>> dailyQuestsFuture;
  late Future<List<Map<String, dynamic>>> monthlyQuestsFuture;

  @override
  void initState() {
    super.initState();
    dailyQuestsFuture = loadQuestsData('assets/quests/daily_quests.json');
    monthlyQuestsFuture = loadQuestsData('assets/quests/monthly_quests.json');
  }

  Future<List<Map<String, dynamic>>> loadQuestsData(String filePath) async {
    try {
      String jsonData = await rootBundle.loadString(filePath);
      List<dynamic> data = json.decode(jsonData);
      List<Map<String, dynamic>> quests = List<Map<String, dynamic>>.from(data);
      return quests;
    } catch (error) {
      print('Erreur de chargement de données: $error');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              AppLocalizations.of(context)!.dailyQuests,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: dailyQuestsFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final dailyQuests = snapshot.data!;
                  List<Widget> questWidgets = [];
                  int questGoal0 = dailyQuests[0]['goal'] as int;
                  int questProgress0 = player.stats["Clic"] as int;

                  int questGoal1 = dailyQuests[1]['goal'] as int;
                  int questProgress1 = player.tapAttack as int;

                  int questGoal2 = dailyQuests[2]['goal'] as int;
                  int questProgress2 = player.stats["Monstres battus"] as int;

                  bool isComplete0 = questProgress0 >= questGoal0;
                  bool isComplete1 = questProgress1 >= questGoal1;
                  bool isComplete2 = questProgress2 >= questGoal2;

                  questWidgets.add(
                    Column(
                      children: [
                        Column(
                          children: [
                            ListTile(
                              title: Text(dailyQuests[0]['title']),
                              subtitle: Text(
                                  'Récompense: ${dailyQuests[0]['reward']}'),
                              trailing: Text('$questProgress0 / $questGoal0'),
                              leading: CircularProgressIndicator(
                                value: questProgress0 / questGoal0,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: LinearProgressIndicator(
                                value: questProgress0 / questGoal0,
                                backgroundColor: Colors.grey[300],
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    Colors.blue),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: isComplete0
                                  ? () {
                                      player
                                          .giveMoney(dailyQuests[0]['reward']);
                                      isComplete0 = false;
                                    }
                                  : null,
                              child: Text(AppLocalizations.of(context)!.claim),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            ListTile(
                              title: Text(dailyQuests[1]['title']),
                              subtitle: Text(
                                  'Récompense: ${dailyQuests[1]['reward']}'),
                              trailing: Text('$questProgress1 / $questGoal1'),
                              leading: CircularProgressIndicator(
                                value: questProgress1 / questGoal1,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: LinearProgressIndicator(
                                value: questProgress1 / questGoal1,
                                backgroundColor: Colors.grey[300],
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    Colors.blue),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: isComplete1
                                  ? () {
                                      player
                                          .giveMoney(dailyQuests[1]['reward']);
                                    }
                                  : null,
                              child: Text(AppLocalizations.of(context)!.claim),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            ListTile(
                              title: Text(dailyQuests[2]['title']),
                              subtitle: Text(
                                  'Récompense: ${dailyQuests[2]['reward']}'),
                              trailing: Text('$questProgress2 / $questGoal2'),
                              leading: CircularProgressIndicator(
                                value: questProgress2 / questGoal2,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: LinearProgressIndicator(
                                value: questProgress2 / questGoal2,
                                backgroundColor: Colors.grey[300],
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    Colors.blue),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: isComplete2
                                  ? () {
                                      player
                                          .giveMoney(dailyQuests[2]['reward']);
                                      isComplete2 = false;
                                    }
                                  : null,
                              child: Text(AppLocalizations.of(context)!.claim),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );

                  return Column(
                    children: [
                      const SizedBox(height: 13),
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
            padding: const EdgeInsets.all(16.0),
            child: Text(
              AppLocalizations.of(context)!.monthlyQuests,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: monthlyQuestsFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final monthlyQuests = snapshot.data!;
                  List<Widget> questWidgets = [];
                  int questMGoal0 = monthlyQuests[0]['goal'] as int;
                  int questMProgress0 = player.stats["Clic"] as int;

                  int questMGoal1 = monthlyQuests[1]['goal'] as int;
                  int questMProgress1 = player.tapAttack as int;

                  int questMGoal2 = monthlyQuests[2]['goal'] as int;
                  int questMProgress2 = player.money as int;

                  bool isCompleteM0 = questMProgress0 >= questMGoal0;
                  bool isCompleteM1 = questMProgress1 >= questMGoal1;
                  bool isCompleteM2 = questMProgress2 >= questMGoal2;

                  questWidgets.add(
                    Column(
                      children: [
                        Column(
                          children: [
                            ListTile(
                              title: Text(monthlyQuests[0]['title']),
                              subtitle: Text(
                                  '${AppLocalizations.of(context)!.reward}: ${monthlyQuests[0]['reward']}'),
                              trailing: Text('$questMProgress0 / $questMGoal0'),
                              leading: CircularProgressIndicator(
                                value: questMProgress0 / questMGoal0,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: LinearProgressIndicator(
                                value: questMProgress0 / questMGoal0,
                                backgroundColor: Colors.grey[300],
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    Colors.blue),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: isCompleteM0
                                  ? () {
                                      player.giveMoney(
                                          monthlyQuests[0]['reward']);
                                      isCompleteM0 = false;
                                    }
                                  : null,
                              child: Text(AppLocalizations.of(context)!.claim),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            ListTile(
                              title: Text(monthlyQuests[1]['title']),
                              subtitle: Text(
                                  'Récompense: ${monthlyQuests[1]['reward']}'),
                              trailing: Text('$questMProgress1 / $questMGoal1'),
                              leading: CircularProgressIndicator(
                                value: questMProgress1 / questMGoal1,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: LinearProgressIndicator(
                                value: questMProgress1 / questMGoal1,
                                backgroundColor: Colors.grey[300],
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    Colors.blue),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: isCompleteM1
                                  ? () {
                                      player.giveMoney(
                                          monthlyQuests[1]['reward']);
                                    }
                                  : null,
                              child: Text(AppLocalizations.of(context)!.claim),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            ListTile(
                              title: Text(monthlyQuests[2]['title']),
                              subtitle: Text(
                                  'Récompense: ${monthlyQuests[2]['reward']}'),
                              trailing: Text('$questMProgress2 / $questMGoal2'),
                              leading: CircularProgressIndicator(
                                value: questMProgress2 / questMGoal2,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: LinearProgressIndicator(
                                value: questMProgress2 / questMGoal2,
                                backgroundColor: Colors.grey[300],
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    Colors.blue),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: isCompleteM2
                                  ? () {
                                      player.giveMoney(
                                          monthlyQuests[2]['reward']);
                                      isCompleteM2 = false;
                                    }
                                  : null,
                              child: Text(AppLocalizations.of(context)!.claim),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );

                  return Column(
                    children: [
                      const SizedBox(height: 13),
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
