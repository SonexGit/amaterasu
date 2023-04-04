import 'package:amaterasu/entities/equipment.dart';
import 'package:amaterasu/utils/style.dart';
import 'package:amaterasu/widgets/equipment/equipment_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final List<Equipment> equipments = Equipment.shopEquipments.keys.toList();
  int _currentCarouselIndex = 0;

  // TODO : Lors du changement de langue, les équipements ne sont pas traduits

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations.of(context)!.dailyEquipments,
            textAlign: TextAlign.center,
            style: Style.headlineStyleHome
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            decoration: BoxDecoration(color: Colors.grey.shade300),
            child: CarouselSlider.builder(
              itemCount: equipments.length,
              options: CarouselOptions(
                height: 200,
                viewportFraction: 0.45,
                enableInfiniteScroll: true,
                enlargeCenterPage: false,
                onPageChanged: (index, _) {
                  setState(() {
                    _currentCarouselIndex = index;
                  });
                },
              ),
              itemBuilder: (BuildContext context, int index, int _) {
                final equipment = equipments[index];
                return EquipmentCard(
                  equipment: equipment,
                  id: equipment.id,
                  name: equipment.name,
                  price: equipment.price,
                  rarity: equipment.rarity,
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              equipments.length,
              (index) => DotIndicator(
                active: index == _currentCarouselIndex,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  final bool active;
  const DotIndicator({super.key, required this.active});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        color: active ? Style.primaryColor : Colors.grey.shade300,
        shape: BoxShape.circle,
      ),
    );
  }
}