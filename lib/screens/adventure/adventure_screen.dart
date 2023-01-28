import 'package:flutter/material.dart';

class AdventureScreen extends StatefulWidget {
  const AdventureScreen({super.key});

  @override
  State<AdventureScreen> createState() => _AdventureScreenState();
}

class _AdventureScreenState extends State<AdventureScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Aventure"),
    );
  }
}