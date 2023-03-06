import 'package:flutter/material.dart';

import '../../entities/enemy.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        color: Colors.grey.shade300,
        child: Column(
          children: [
            Text(player.name),
            Column(
              children: player.stats.entries
                  .map<MapEntry<String, Widget>>(
                    (entry) => MapEntry(
                      entry.key,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            entry.key,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            entry.value.toStringAsFixed(2),
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  )
                  .map<Widget>((entry) => entry.value)
                  .toList(),
            ),
          ],
        ));
  }
}
