import 'package:amaterasu/screens/fight/fight_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    image: AssetImage("assets/images/adventure.png"))),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.withOpacity(0.8),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              onPressed: () => selectedIndex.value = 1,
              child: Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.grey,
                child: Text(
                  AppLocalizations.of(context)!.adventure,
                  style: const TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    image: AssetImage("assets/images/specialevent.png"))),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple.withOpacity(0.8),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const AlertDialog(
                        content: Text('Disponible le 15 mai à 00h'),
                      );
                    });
              },
              child: Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.grey,
                child: Text(
                  AppLocalizations.of(context)!.specialEvent,
                  style: const TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
