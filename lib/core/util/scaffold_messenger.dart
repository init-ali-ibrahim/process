import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:process/app.dart';

void showScaffoldMessenger({
  required BuildContext context,
  required String textContent,
  String? lottieAssetsJson,
  Widget? content,
  bool isCustom = false,
  Duration duration = const Duration(seconds: 2),
}) {
  ScaffoldMessengerState? messenger = AppGlobals.scaffoldMessengerKey.currentState;

  if (messenger != null) {
    messenger.hideCurrentSnackBar();

    messenger.showSnackBar(
      SnackBar(
        content: isCustom
            ? content!
            : ScaffoldMessengerContent(
                lottieAssetsJson: lottieAssetsJson,
                textContent: textContent,
              ),
        duration: duration,
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
        dismissDirection: DismissDirection.horizontal,
        clipBehavior: Clip.antiAlias,
        padding: EdgeInsets.zero,
      ),
    );
  }
}

class ScaffoldMessengerContent extends StatefulWidget {
  const ScaffoldMessengerContent({
    super.key,
    required this.textContent,
    this.lottieAssetsJson,
  });

  final String textContent;
  final String? lottieAssetsJson;

  @override
  State<ScaffoldMessengerContent> createState() => _ScaffoldMessengerContentState();
}

class _ScaffoldMessengerContentState extends State<ScaffoldMessengerContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
  }

  @override
  void dispose() {
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Material(
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(12),
            elevation: 1,
            color: Colors.white,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 50,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  if (widget.lottieAssetsJson != null)
                    Lottie.asset(
                      widget.lottieAssetsJson!,
                      fit: BoxFit.fitHeight,
                      height: 20,
                    ),
                  if (widget.lottieAssetsJson != null) const SizedBox(width: 8),
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
