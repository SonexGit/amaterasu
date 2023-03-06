import 'dart:convert';

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
  Future<void> loadData() async {
    String jsonString =
        await rootBundle.loadString('assets/upgrades/upgrades.json');
    List<dynamic>? jsonList = jsonDecode(jsonString);
    if (jsonList != null) {
      data = jsonList.cast<Map<String, dynamic>>();
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
            color: Colors.grey.shade300,
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                MapEntry<String, dynamic> entry =
                    data.elementAt(index) as MapEntry<String, dynamic>;
                return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(children: [
                        Row(children: const [
                          Text("Nom",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w700))
                        ]),
                        Row(children: [
                          Text(entry.key, textAlign: TextAlign.left)
                        ]),
                      ]),
                      Column(children: [
                        Row(children: const [
                          Text("Description", textAlign: TextAlign.left)
                        ]),
                        Row(children: [
                          Text(entry.value.toString(),
                              textAlign: TextAlign.left)
                        ]),
                      ]),
                    ]);
              },
            ),
          ),
          Column(
            children: [
              AnimatedButton(
                width: 80,
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
                        'Acheter',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "80g",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ]),
              ),
            ],
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
              const Text("Améliorations"),
            ])));
  }
}
