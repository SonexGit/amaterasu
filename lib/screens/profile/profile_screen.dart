import 'package:flutter/material.dart';
import 'package:multiavatar/multiavatar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../entities/enemy.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _selectedAvatar = "Bienvenue";
  bool _showBienvenue = true;
  bool _showFemme = true;
  bool _showHomme = true;

  @override
  void initState() {
    super.initState();
    _loadSelectedAvatar();
  }

  void _loadSelectedAvatar() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedAvatar = prefs.getString('selectedAvatar') ?? 'Bienvenue';
      _showBienvenue = _selectedAvatar == 'Bienvenue';
      _showFemme = _selectedAvatar == 'Femme';
      _showHomme = _selectedAvatar == 'Homme';
    });
  }

  void _saveSelectedAvatar(String value) async {
    var prefs = await SharedPreferences.getInstance();
    print("test: $_selectedAvatar");
    await prefs.setString('selectedAvatar', value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      color: Colors.grey.shade300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            player.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              const SizedBox(height: 16),
              Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedAvatar = "Bienvenue";
                              _showBienvenue = true;
                              _showFemme = false;
                              _showHomme = false;
                            });
                            _saveSelectedAvatar(_selectedAvatar);
                          },
                          child: CircleAvatar(
                            backgroundColor: _showBienvenue
                                ? Colors.white
                                : Colors.transparent,
                            radius: 30,
                            backgroundImage:
                                const AssetImage("assets/screen/enfants.png"),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedAvatar = "Femme";
                              _showBienvenue = false;
                              _showFemme = true;
                              _showHomme = false;
                            });
                            _saveSelectedAvatar(_selectedAvatar);
                          },
                          child: CircleAvatar(
                            backgroundColor:
                                _showFemme ? Colors.white : Colors.transparent,
                            radius: 30,
                            backgroundImage:
                                const AssetImage("assets/screen/Femme.png"),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedAvatar = "Homme";
                              _showBienvenue = false;
                              _showFemme = false;
                              _showHomme = true;
                            });
                            _saveSelectedAvatar(_selectedAvatar);
                          },
                          child: CircleAvatar(
                            backgroundColor:
                                _showHomme ? Colors.white : Colors.transparent,
                            radius: 30,
                            backgroundImage:
                                AssetImage("assets/screen/Homme.png"),
                          ),
                        ),
                      ]),
                ],
              ),
              const SizedBox(height: 20),
              Text("Avatar sélectionné : $_selectedAvatar"),
            ],
          ),
          const SizedBox(height: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'STATISTIQUES',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              ...player.stats.entries.map(
                (entry) => Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          entry.key,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          entry.value.toStringAsFixed(2),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(
                        height: 10), // espace vertical entre chaque ligne
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
