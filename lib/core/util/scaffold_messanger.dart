import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void showScaffoldMessenger({
  required BuildContext context,
  required String textContent,
  required String lottieAssetsJson,
  Widget? content,
  bool isCustom = false,
  Duration duration = const Duration(seconds: 2),
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: isCustom == true
          ? content!
          : ScaffoldMessengerContent(
              lottieAssetsJson: lottieAssetsJson,
              textContent: textContent,
            ),
      duration: duration,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      dismissDirection: DismissDirection.horizontal,
      padding: const EdgeInsets.all(0),
    ),
  );
}

class ScaffoldMessengerContent extends StatefulWidget {
  const ScaffoldMessengerContent({super.key, required this.textContent, required this.lottieAssetsJson});

  final String textContent;
  final String lottieAssetsJson;

  @override
  State<ScaffoldMessengerContent> createState() => _ScaffoldMessengerContentState();
}

class _ScaffoldMessengerContentState extends State<ScaffoldMessengerContent> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        elevation: 1,
        color: Colors.white,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 50,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Lottie.asset(
                widget.lottieAssetsJson,
                fit: BoxFit.fitHeight,
                height: 20,
                controller: _controller,
                onLoaded: (composition) {
                  _controller.duration = composition.duration;
                  _controller.forward();
                },
              ),
              const SizedBox(width: 8),
              Text(
                widget.textContent,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
