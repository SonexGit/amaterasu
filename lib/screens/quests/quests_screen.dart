import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QuestsPage extends StatefulWidget {
  @override
  _QuestsPageState createState() => _QuestsPageState();
}

class _QuestsPageState extends State<QuestsPage> {
  late Future<List<Map<String, dynamic>>> dailyQuestsFuture;
  late Future<List<Map<String, dynamic>>> monthlyQuestsFuture;

  @override
  void initState() {
    super.initState();
    dailyQuestsFuture = loadQuestsData('assets/quests/daily_quests.json');
    monthlyQuestsFuture = loadQuestsData('assets/quests/monthly_quests.json');
  }

  Future<List<Map<String, dynamic>>> loadQuestsData(String filePath) async {
    String jsonData = await rootBundle.loadString(filePath);
    List<dynamic> data = json.decode(jsonData);
    List<Map<String, dynamic>> quests = List<Map<String, dynamic>>.from(data);
    return quests;
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
                  for (var quest in dailyQuests) {
                    int questGoal = quest['goal'] as int;
                    int questProgress = quest['progress'] ?? 3;
                    bool isComplete = questProgress >= questGoal;
                    questWidgets.add(
                      Column(
                        children: [
                          ListTile(
                            title: Text(quest['title']),
                            subtitle: Text('Récompense: ${quest['reward']}'),
                            trailing: Text('$questProgress / $questGoal'),
                            leading: CircularProgressIndicator(
                              value: questProgress / questGoal,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: LinearProgressIndicator(
                              value: questProgress / questGoal,
                              backgroundColor: Colors.grey[300],
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.blue),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: isComplete ? () {} : null,
                            child: Text(AppLocalizations.of(context)!.claim),
                          ),
                        ],
                      ),
                    );
                  }

                  return Column(
                    children: [
                      const SizedBox(height: 13),
                      Expanded(
                        child: ListView(children: questWidgets),
                      ),
                    ],
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
              future: dailyQuestsFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final dailyQuests = snapshot.data!;
                  List<Widget> questWidgets = [];
                  for (var quest in dailyQuests) {
                    int questGoal = quest['goal'] as int;
                    int questProgress = quest['progress'] ?? 0;
                    bool isComplete = questProgress >= questGoal;
                    questWidgets.add(
                      Column(
                        children: [
                          ListTile(
                            title: Text(quest['title']),
                            subtitle: Text('${AppLocalizations.of(context)!.reward}: ${quest['reward']}'),
                            trailing: Text('$questProgress / $questGoal'),
                            leading: CircularProgressIndicator(
                              value: questProgress / questGoal,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: LinearProgressIndicator(
                              value: questProgress / questGoal,
                              backgroundColor: Colors.grey[300],
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.blue),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: isComplete ? () {} : null,
                            child: Text(AppLocalizations.of(context)!.claim),
                          ),
                        ],
                      ),
                    );
                  }

                  return Column(
                    children: [
                      const SizedBox(height: 13),
                      Expanded(
                        child: ListView(children: questWidgets),
                      ),
                    ],
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
