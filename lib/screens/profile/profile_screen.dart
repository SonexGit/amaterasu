import 'package:amaterasu/entities/player.dart';
import 'package:amaterasu/utils/style.dart';
import 'package:amaterasu/widgets/equipment/equipment_icon.dart';
import 'package:amaterasu/widgets/equipment/equipment_slot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    setState(() {
      player.stats[0] = player.tapAttack;
      player.stats[1] = player.passiveAttack;
      player.stats[4] = player.money;
    });
    return DefaultTabController(
      length: 2, // Nombre d'onglets
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey[300],
                ),
                height: kToolbarHeight - 8,
                child: TabBar(
                  controller: _tabController,
                  unselectedLabelColor: Colors.black,
                  labelColor: Colors.white,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Style.primaryColor,
                  ),
                  tabs: [
                    Tab(text: AppLocalizations.of(context)!.profile),
                    Tab(text: AppLocalizations.of(context)!.inventory),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  SingleChildScrollView(
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
                        const SizedBox(height: 5),
                        Text(
                            "${AppLocalizations.of(context)!.level(player.level)} • ${player.experience}/${player.nextLevelExp}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppLocalizations.of(context)!.statistics,
                                style: Style.profileHeadline),
                            const SizedBox(height: 20),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.05),
                                child: Column(
                                  children: player.getStats(context).entries
                                      .map(
                                        (entry) => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(entry.key,
                                                style: Style.profileStats.merge(
                                                    const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold))),
                                            Text(entry.value.toStringAsFixed(2),
                                                style: Style.profileStats),
                                          ],
                                        ),
                                      )
                                      .expand((element) =>
                                          [element, const Divider()])
                                      .take(player.getStats(context).entries.length * 2 - 1)
                                      .toList(),
                                )),
                            const SizedBox(height: 40),
                            Text(AppLocalizations.of(context)!.equipments,
                                style: Style.profileHeadline),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: Wrap(
                                    alignment: WrapAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    spacing: 16,
                                    runSpacing: 8,
                                    children: player.equipments.keys.map((key) {
                                      return EquipmentSlot(type: key);
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: [
                        Wrap(
                            spacing: 20.0,
                            runSpacing: 0.0,
                            alignment: WrapAlignment.center,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.swap_vert),
                                  const SizedBox(width: 5),
                                  DropdownButton<int>(
                                    value: player.inventoryOrderIndex,
                                    onChanged: (int? newValue) {
                                      setState(() {
                                        player.updateOrder(newValue!);
                                      });
                                    },
                                    items: Player.getOrdersLocalization(context)
                                        .asMap()
                                        .map((index, value) {
                                          return MapEntry(
                                            index,
                                            DropdownMenuItem<int>(
                                              value: index,
                                              child: Text(
                                                  Player.getOrderLocalization(
                                                      context, index),
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          );
                                        })
                                        .values
                                        .toList(),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.filter_alt),
                                  const SizedBox(width: 5),
                                  DropdownButton<int>(
                                    value: player.inventoryFilterIndex,
                                    onChanged: (int? newValue) {
                                      setState(() {
                                        player.updateFilter(newValue!);
                                      });
                                    },
                                    items: Player.getFiltersLocalization(
                                            context)
                                        .asMap()
                                        .map((index, value) {
                                          return MapEntry(
                                            index,
                                            DropdownMenuItem<int>(
                                              value: index,
                                              child: Text(
                                                  Player.getFilterLocalization(
                                                      context, index),
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          );
                                        })
                                        .values
                                        .toList(),
                                  )
                                ],
                              ),
                            ]),
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                            ),
                            itemCount:
                                null, // Utiliser null pour une liste infinie
                            itemBuilder: (BuildContext context, int index) {
                              if (index >= player.inventory.length) {
                                // Afficher un container vide pour les cases vides de la grille
                                return Container(
                                  margin: const EdgeInsets.all(4.0),
                                  color: Colors.grey[200],
                                );
                              }
                              return GridTile(
                                child: Container(
                                  margin: const EdgeInsets.all(4.0),
                                  color: Colors.grey[200],
                                  child: Center(
                                    child: EquipmentIcon(
                                      equipment: player.inventory[index],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
