import 'dart:async';
import 'package:amaterasu/screens/core.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _showOverlay = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);
    _controller.forward();
    Timer(const Duration(seconds: 2), () {
      // Remove the splash screen overlay
      setState(() {
        _showOverlay = false;
      });
      _controller.reverse();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Core(),
        if (_showOverlay)
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white
              ),
              child: Center(
                child: Image.asset(
                  'assets/icon/icon.png',
                  width: 300,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
