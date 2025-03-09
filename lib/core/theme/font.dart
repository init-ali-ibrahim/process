import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const List<String> availableFonts = <String>[
  'Roboto',
  'Montserrat',
  'Inter',
  'Poppins',
  'OpenSans',
];

final StateNotifierProvider<FontNotifier, String> fontProvider =
    StateNotifierProvider<FontNotifier, String>((Ref ref) {
  return FontNotifier();
});

class FontNotifier extends StateNotifier<String> {
  FontNotifier() : super('Inter') {
    _loadFont();
  }

  Future<void> setFont(String font) async {
    state = font;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_font', font);
  }

  Future<void> _loadFont() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    state = prefs.getString('selected_font') ?? 'Roboto';
  }
}
