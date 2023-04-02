import 'package:amaterasu/screens/fight/fight_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_button/animated_button.dart';
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
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 50),
            Stack(
              children: [
                AnimatedButton(
                  color: Colors.green,
                  onPressed: () => selectedIndex.value = 1,
                  enabled: true,
                  shadowDegree: ShadowDegree.light,
                  duration: 400,
                  child: Shimmer.fromColors(
                    baseColor: Colors.white,
                    highlightColor: Colors.grey,
                    child: Text(
                      AppLocalizations.of(context)!.adventure,
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const Positioned.fill(
                  left: 150,
                  bottom: 30,
                  child: Icon(
                    Icons.lock_open,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Stack(
              children: [
                AnimatedButton(
                  color: Colors.blue,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.grey[200],
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text(
                                  'Evenement Spécial',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text('Disponible le 15 mai à 00h'),
                              ],
                            ),
                          ),
                        );
                      },
                    );

                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.of(context).pop();
                    });
                  },
                  enabled: true,
                  shadowDegree: ShadowDegree.light,
                  child: Shimmer.fromColors(
                    baseColor: Colors.white,
                    highlightColor: Colors.blue,
                    child: Text(
                      AppLocalizations.of(context)!.specialEvent,
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const Positioned(
                  right: 10,
                  top: 10,
                  child: Icon(
                    Icons.lock,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
