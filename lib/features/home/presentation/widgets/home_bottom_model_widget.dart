import 'package:flutter/material.dart';

Future<void> showAppbarCountry(BuildContext context) async {
  String? selectedCity;

  await showModalBottomSheet<void>(
    backgroundColor: Colors.white,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
    ),
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Выберите город доставки',
                      style: TextStyle(fontSize: 20),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _buildCityOption('Алматы', 'assets/image/almaty-logo.png', selectedCity, setState),
                    _buildCityOption('Астана', 'assets/image/astana-logo.png', selectedCity, setState),
                    _buildCityOption('Уральск', 'assets/image/uralsk-logo.png', selectedCity, setState),
                    _buildCityOption('Актобе', 'assets/image/aktobe-logo.png', selectedCity, setState),
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  );

  if (selectedCity != null) {
    print('Выбранный город: $selectedCity');
    // сюда писать код.
  }
}

Widget _buildCityOption(String cityName, String assetPath, String? selectedCity, StateSetter setState) {
  final isSelected = selectedCity == cityName;

  return GestureDetector(
    onTap: () {
      setState(() {
        selectedCity = cityName;
      });
    },
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFE3D8D8) : Colors.transparent,
        border: Border.all(
          color: isSelected ? const Color(0xFFB71C1C) : Colors.grey,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(assetPath, width: 50),
          const SizedBox(height: 8),
          Text(
            cityName,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    ),
  );
}
