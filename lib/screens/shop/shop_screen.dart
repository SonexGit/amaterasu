import 'package:flutter/material.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.red, child: const Text("Boutique"));
  }
}

class ShopGrab extends StatelessWidget {
  const ShopGrab({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: DecoratedBox(
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3)
                  )
                ]
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text("Boutique"),
              const SizedBox(height: 5.0),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
                SizedBox(
                    width: 80,
                    height: 6,
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius:
                                BorderRadius.all(Radius.circular(5)))))
              ])
            ])));
  }
}
