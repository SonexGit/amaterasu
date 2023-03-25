// ignore_for_file: prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:amaterasu/entities/enemy.dart';
import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UpgradesScreen extends StatefulWidget {
  const UpgradesScreen({super.key});

  @override
  State<UpgradesScreen> createState() => _UpgradesScreenState();
}

class _UpgradesScreenState extends State<UpgradesScreen> {
  List<Map<String, dynamic>> data = [];
  bool _isLoading = true;

  Future<void> loadData() async {
    String jsonString =
        await rootBundle.loadString('assets/upgrades/upgrades.json');
    List<dynamic>? jsonList = jsonDecode(jsonString);
    if (jsonList != null) {
      data = jsonList.cast<Map<String, dynamic>>();
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
      child: ListView(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AnimatedButton(
                    width: 40,
                    height: 30,
                    color: Colors.blue,
                    onPressed: () {},
                    enabled: false,
                    shadowDegree: ShadowDegree.light,
                    duration: 50,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            'x1',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ]),
                  ),
                  AnimatedButton(
                    width: 40,
                    height: 30,
                    color: Colors.blue,
                    onPressed: () {},
                    enabled: true,
                    shadowDegree: ShadowDegree.light,
                    duration: 50,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            'x10',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ]),
                  ),
                  AnimatedButton(
                    width: 40,
                    height: 30,
                    color: Colors.blue,
                    onPressed: () {},
                    enabled: true,
                    shadowDegree: ShadowDegree.light,
                    duration: 50,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            'x100',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ]),
                  ),
                ],
              )),
          // mapper le container ci-dessous sur le tableau des améliorations du joueur
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            color: Colors.white,
            child: SizedBox(
              height: 600,
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map<String, dynamic> entry = data[index];
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(children: [
                                Row(children: [
                                  Text(
                                    entry.values.elementAt(1),
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  )
                                ]),
                                Row(children: [
                                  Text(entry.values.elementAt(2),
                                      textAlign: TextAlign.left)
                                ]),
                                Row(children: [
                                  const Divider(height: 20, color: Colors.red),
                                ]),
                              ]),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      AnimatedButton(
                                        width: 60,
                                        height: 50,
                                        color: Colors.blue,
                                        onPressed: () {
                                          if (player.money >=
                                              entry.values.elementAt(3)) {
                                            player.money = player.money -
                                                entry.values.elementAt(3);
                                          }
                                        },
                                        enabled: true,
                                        shadowDegree: ShadowDegree.light,
                                        duration: 50,
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        'Acheter',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                        textAlign:
                                                            TextAlign.right,
                                                      ),
                                                    ],
                                                  ),
                                                  Row(children: [
                                                    Text(
                                                        entry.values
                                                            .elementAt(3)
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.right)
                                                  ]),
                                                ],
                                              ),
                                            ]),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ]);
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class UpgradesGrab extends StatelessWidget {
  const UpgradesGrab({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: DecoratedBox(
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3))
                ]),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(
                    width: 80,
                    height: 6,
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade700,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)))))
              ]),
              const SizedBox(height: 5.0),
              const Text("Améliorations"),
            ])));
  }
}
