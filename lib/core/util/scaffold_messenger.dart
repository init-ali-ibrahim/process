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
        duration: duration,
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
  const ScaffoldMessengerContent({
    super.key,
    required this.textContent,
    required this.lottieAssetsJson,
    required this.duration,
  });

  final String textContent;
  final String lottieAssetsJson;
  final Duration duration;

  @override
  State<ScaffoldMessengerContent> createState() => _ScaffoldMessengerContentState();
}

class _ScaffoldMessengerContentState extends State<ScaffoldMessengerContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));

    _controller.forward();

    Future.delayed(widget.duration - const Duration(milliseconds: 100), () {
      if (!_isDisposed) {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Padding(
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
                      if (!_isDisposed) {
                        setState(() {
                          _controller.duration = composition.duration;
                          _controller.forward();
                        });
                      }
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
        ),
      ),
    );
  }
}

