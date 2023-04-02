// ignore_for_file: prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures

import 'dart:convert';
import 'dart:math';

import 'package:amaterasu/entities/player.dart';
import 'package:amaterasu/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class UpgradesScreen extends StatefulWidget {
  const UpgradesScreen({super.key});

  @override
  State<UpgradesScreen> createState() => _UpgradesScreenState();
}

class _UpgradesScreenState extends State<UpgradesScreen> {
  Player player = Player();

  List<Map<String, dynamic>> data = [];
  bool _isLoading = true;
  double multiplier = 1.0;
  List<int> basePrice = List.empty(growable: true);

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

  double _getPrice(int index) {
    if (index < 8) {
      late double finalPrice = 0;
      for (double i = multiplier; i != 0; i--) {
        finalPrice += basePrice[index] *
            pow(1.2, player.getUpgradeLevel(index) + multiplier - i);
      }
      return finalPrice;
    } else {
      return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: Column(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                height: 70,
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          multiplier = 1.0;
                          //updatePrices(multiplier);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: multiplier == 1.0
                            ? Colors.grey[300]
                            : Style.primaryColor,
                        minimumSize: const Size(50, 40),
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text(
                        'x1',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          multiplier = 10.0;
                          //updatePrices(multiplier);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: multiplier == 10.0
                            ? Colors.grey[300]
                            : Style.primaryColor,
                        minimumSize: const Size(50, 40),
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text(
                        'x10',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          multiplier = 50.0;
                          //updatePrices(multiplier);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: multiplier == 50.0
                            ? Colors.grey[300]
                            : Style.primaryColor,
                        minimumSize: const Size(50, 40),
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text(
                        'x50',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          multiplier = 100.0;
                          //updatePrices(multiplier);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: multiplier == 100.0
                            ? Colors.grey[300]
                            : Style.primaryColor,
                        minimumSize: const Size(50, 40),
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text(
                        'x100',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
            flex: 5,
            child: Container(
              color: Colors.white,
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map<String, dynamic> entry = data[index];
                        basePrice.add(entry['price'].round());
                        int price = _getPrice(index).round();
                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      entry['name'],
                                      style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 2.0),
                                    Text(
                                        "Niveau ${player.getUpgradeLevel(index)}",
                                        style: const TextStyle(fontSize: 12.0)),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      entry['description'],
                                      style: const TextStyle(fontSize: 14.0),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              ElevatedButton(
                                onPressed: player.money >= price
                                    ? () {
                                        if (player.money >= price) {
                                          setState(() {
                                            player
                                                .buy(_getPrice(index).round());
                                            for (double i = multiplier;
                                                i != 0;
                                                i--) {
                                              player.levelUpUpgrade(index);
                                            }
                                            entry['price'] =
                                                _getPrice(index).round();
                                          });
                                        }
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Style.primaryColor,
                                  minimumSize: const Size(90, 60),
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.buy,
                                      style: const TextStyle(fontSize: 14.0),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          NumberFormat.compactCurrency(
                                                  decimalDigits: 0, symbol: '')
                                              .format(_getPrice(index).round()),
                                          style:
                                              const TextStyle(fontSize: 12.0),
                                        ),
                                        const SizedBox(width: 4.0),
                                        const Icon(Icons.toll, size: 10),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
            ),
          )
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
              Text(AppLocalizations.of(context)!.upgrades),
            ])));
  }
}
