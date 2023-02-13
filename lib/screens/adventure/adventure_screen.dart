import 'package:amaterasu/screens/fight/fight_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_button/animated_button.dart';

class AdventureScreen extends StatefulWidget {
  const AdventureScreen({super.key});

  @override
  State<AdventureScreen> createState() => _AdventureScreenState();
}

ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);

class _AdventureScreenState extends State<AdventureScreen> {
  static final List<Widget> _widgetOptions = <Widget>[
    const AdventureSelectionScreen(),
    const FightScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ValueListenableBuilder<int>(
      builder: (BuildContext context, int value, Widget? child) {
        return _widgetOptions[value];
      },
      valueListenable: selectedIndex,
    ));
  }
}

class AdventureSelectionScreen extends StatefulWidget {
  const AdventureSelectionScreen({super.key});

  @override
  State<AdventureSelectionScreen> createState() =>
      _AdventureSelectionScreenState();
}

class _AdventureSelectionScreenState extends State<AdventureSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 50),
            AnimatedButton(
              color: Colors.green,
              onPressed: () => selectedIndex.value = 1,
              enabled: true,
              shadowDegree: ShadowDegree.light,
              duration: 400,
              child: const Text(
                'Aventure',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 20),
            AnimatedButton(
              color: Colors.blue,
              onPressed: () {},
              enabled: true,
              shadowDegree: ShadowDegree.light,
              child: const Text(
                'Evenement Spécial',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
