import 'dart:async';

import 'package:amaterasu/data/main_menu.dart';
import 'package:amaterasu/entities/enemy.dart';
import 'package:amaterasu/entities/player.dart';
import 'package:amaterasu/entities/equipment.dart';
import 'package:amaterasu/screens/adventure/adventure_screen.dart';
import 'package:amaterasu/screens/home/home_screen.dart';
import 'package:amaterasu/screens/profile/profile_screen.dart';
import 'package:amaterasu/screens/quests/quests_screen.dart';
import 'package:amaterasu/screens/shop/shop_screen.dart';
import 'package:amaterasu/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Player player = Player();
Enemy enemy = Enemy();

class Core extends StatefulWidget {
  const Core({super.key});

  @override
  State<Core> createState() => _CoreState();
}

// This value is equal to 0 because its equal to the Home index in the menu
int selectedIndex = 0;

class _CoreState extends State<Core> {
  late PageController _pageController;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const AdventureScreen(),
    const ShopScreen(),
    QuestsPage(),
    const ProfileScreen(),
  ];

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

    // Initialize the important entities
    player;
    enemy;
    Equipment.readEquipmentJson();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: prefer_const_constructors
      appBar: MyAppBar(),
      body: SafeArea(
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
      )),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 26,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.grey[700],
        unselectedItemColor: Colors.grey[700]?.withOpacity(0.3),
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_filled), label: "Accueil"),
          BottomNavigationBarItem(icon: Icon(Icons.park), label: "Aventure"),
          BottomNavigationBarItem(
              icon: Icon(Icons.storefront), label: "Boutique"),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment), label: "Quêtes"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(MainMenu.names[selectedIndex]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(Icons.toll, size: 18),
              const SizedBox(width: 8.0),
              Text(player.formattedMoney(), style: Style.moneyAppBar),
            ],
          ),
        ],
      ),
      actions: [
        PopupMenuButton<int>(
          icon: const Icon(Icons.menu),
          itemBuilder: (context) =>
              [const PopupMenuItem(value: 0, child: Text("Paramètres"))],
          tooltip: "Menu",
        ),
      ],
      systemOverlayStyle:
          const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: Style.mainGradient,
            transform: GradientRotation(90),
          ),
        ),
      ),
    );
  }
}
