import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomizeSideMenuWidget extends StatelessWidget {
  final String currentSelection;
  final Function(String) onSelectionChanged;
  final WebViewController webViewController;

  const CustomizeSideMenuWidget({
    Key? key,
    required this.currentSelection,
    required this.onSelectionChanged,
    required this.webViewController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: const BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.only(topRight: Radius.circular(10)),
      ),
      margin: const EdgeInsets.only(top: 10),
      width: 90,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          _buildOption(
            icon: Icons.cake,
            label: 'Форма',
            isSelected: currentSelection == 'Shape',
            onTap: () => onSelectionChanged('Shape'),
          ),
          const SizedBox(height: 10),
          _buildOption(
            icon: Icons.restaurant_menu,
            label: 'Начинка',
            isSelected: currentSelection == 'Flavor',
            onTap: () {
              webViewController.runJavaScript('document.getElementById("flavor").click();');
              onSelectionChanged('Flavor');
            },
          ),
          const SizedBox(height: 10),
          _buildOption(
            icon: Icons.color_lens,
            label: 'Цвет',
            isSelected: currentSelection == 'Colour',
            onTap: () {
              webViewController.runJavaScript('document.getElementById("colour").click();');
              onSelectionChanged('Colour');
            },
          ),
          const SizedBox(height: 10),
          _buildOption(
            icon: Icons.style_sharp,
            label: 'Заказ',
            isSelected: currentSelection == 'Topping',
            onTap: () => onSelectionChanged('Topping'),
          ),
        ],
      ),
    );
  }

  Widget _buildOption({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 70,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? Colors.red : Colors.white),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? Colors.red : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
