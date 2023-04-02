import 'dart:async';

import 'package:amaterasu/entities/enemy.dart';
import 'package:amaterasu/entities/player.dart';
import 'package:amaterasu/entities/equipment.dart';
import 'package:amaterasu/screens/adventure/adventure_screen.dart';
import 'package:amaterasu/screens/home/home_screen.dart';
import 'package:amaterasu/screens/profile/profile_screen.dart';
import 'package:amaterasu/screens/quests/quests_screen.dart';
import 'package:amaterasu/screens/settings/settings_screen.dart';
import 'package:amaterasu/screens/shop/shop_screen.dart';
import 'package:amaterasu/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

Player player = Player();
Enemy enemy = Enemy();

class Core extends StatefulWidget {
  const Core({super.key});

  @override
  State<Core> createState() => _CoreState();
}

// This value is equal to 0 because its equal to the Home index in the menu
int selectedIndex = 0;

class _CoreState extends State<Core> with WidgetsBindingObserver {
  late PageController _pageController;

  SharedPreferences? _prefs;
  final String _timestampKey = 'timestamp';
  DateTime? _timestamp;

  static late final List<Widget> _widgetOptions;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    _widgetOptions = const <Widget>[
      HomeScreen(),
      AdventureScreen(),
      ShopScreen(),
      QuestsPage(),
      ProfileScreen(),
    ];

    // Initialize the important entities
    player;
    enemy;
    Equipment.setupEquipments();

    // Preparation for when the user quits the app
    WidgetsBinding.instance.addObserver(this);
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _getTimestamp();
  }

  Future<void> _getTimestamp() async {
    int? timestamp = _prefs?.getInt(_timestampKey);
    if (timestamp != null && player.haveSeenTutorial) {
      _timestamp = DateTime.fromMillisecondsSinceEpoch(timestamp);
      player.giveAfkMoney(_timestamp!, DateTime.now());
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.paused) {
      DateTime timestamp = DateTime.now();
      await _prefs?.setInt(_timestampKey, timestamp.millisecondsSinceEpoch);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.altColor,
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight * 1.1),
          child: MyAppBar()),
      body: SafeArea(
          child: Padding(
              padding:
                  const EdgeInsets.only(bottom: 10, left: 20, right: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                    10.0), //définir le rayon de bordure arrondie souhaité
                child: PageView(
                  controller: _pageController,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: _widgetOptions,
                  onPageChanged: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                ),
              ))),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 26,
        backgroundColor: Colors.transparent,
        selectedItemColor: Style.secondaryColor,
        unselectedItemColor: Style.primaryColor.withOpacity(0.3),
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded), label: "Accueil"),
          BottomNavigationBarItem(icon: Icon(Icons.park_rounded), label: "Aventure"),
          BottomNavigationBarItem(
              icon: Icon(Icons.storefront_rounded), label: "Boutique"),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment_rounded), label: "Quêtes"),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: "Profil"),
        ],
      ),
    );
  }
}

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  final Size preferredSize = const Size.fromHeight(56);
}

class _MyAppBarState extends State<MyAppBar> {
  List<String> menuNames = <String>[
    "Home",
    "Adventure",
    "Shop",
    "Quests",
    "Profile"
  ];

  Timer? _timer;

  int counter = 0;

  void _updateMoney(Timer timer) {
    counter++;
    setState(() => player.money);

    // Every second, we get +1 "money"
    if (counter * 100 >= 1000) {
      setState(() => player.money++);
      counter = 0;
    }
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 100), _updateMoney);
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle:
          const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      flexibleSpace: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    [
                      AppLocalizations.of(context)!.home,
                      AppLocalizations.of(context)!.adventure,
                      AppLocalizations.of(context)!.shop,
                      AppLocalizations.of(context)!.quests,
                      AppLocalizations.of(context)!.profile
                    ][selectedIndex],
                    style: Style.appBarTitle),
              ],
            ),
            Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(AppLocalizations.of(context)!.level(player.level),
                        style: Style.appBarInfo.merge(const TextStyle(fontWeight: FontWeight.bold))),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(player.formattedMoney(), style: Style.appBarInfo),
                        const SizedBox(width: 4.0),
                        const Icon(Icons.toll, size: 18, color: Style.primaryColor),
                      ],
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                PopupMenuButton<int>(
                  icon: const Icon(Icons.menu, color: Style.primaryColor),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                        onTap: () {
                          Future.delayed(
                            const Duration(seconds: 0),
                            () => showDialog(
                              context: context,
                              builder: (context) => const SettingsScreen(),
                            ),
                          );
                        },
                        value: 0,
                        child: Text(AppLocalizations.of(context)!.settings))
                  ],
                  tooltip: AppLocalizations.of(context)!.menu,
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
