import 'package:amaterasu/entities/player.dart';
import 'package:amaterasu/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Player player = Player();

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Map<String, String> locToLanguages = {"en": "English", "fr": "Français"};
  Map<String, String> languagesToLoc = {"English": "en", "Français": "fr"};

  // TODO : Ajouter des paramètres ?

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.settings),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(AppLocalizations.of(context)!.language),
            const SizedBox(width: 20),
            DropdownButton<String>(
              value: locToLanguages[player.locale],
              onChanged: (String? newValue) {
                setState(() {
                  player.setLocale(languagesToLoc[newValue]!);
                  MyApp.setLocale(context, Locale(player.locale));
                });
              },
              items: <String>['Français', 'English']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            )
          ]),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context)!.close),
        ),
      ],
    );
  }
}
