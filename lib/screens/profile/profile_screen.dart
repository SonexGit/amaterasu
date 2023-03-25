import 'package:amaterasu/entities/equipment.dart';
import 'package:amaterasu/entities/player.dart';
import 'package:flutter/material.dart';

Player player = Player();

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Nombre d'onglets
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.blue, // Couleur de fond de la tab bar
              child: TabBar(
                controller: _tabController,
                indicatorColor:
                    Colors.white, // Couleur de la barre de sélection
                labelColor:
                    Colors.white, // Couleur de texte de l'onglet sélectionné
                unselectedLabelColor:
                    Colors.white60, // Couleur de texte des autres onglets
                tabs: const [
                  Tab(text: 'Profil'),
                  Tab(text: 'Inventaire'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          player.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Statistiques',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 40),
                            ...player.stats.entries.map(
                              (entry) => Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                      height:
                                          10), // espace vertical entre chaque ligne
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 24.0),
                      child: GridView.count(
                        crossAxisCount: 5,
                        children: player.inventory
                            .map((Equipment equipment) => GridTile(
                                  child: Container(
                                    margin: const EdgeInsets.all(4.0),
                                    color: Colors.grey[300],
                                    child: Center(
                                        child: Image.asset(
                                            "assets/equipments/images/${equipment.id}.png")),
                                  ),
                                ))
                            .toList(),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
