import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomizeAppbarWidget extends StatelessWidget implements PreferredSizeWidget{
  const CustomizeAppbarWidget({super.key, required this.webViewController, required this.totalPrice});

  final WebViewController webViewController;
  final int totalPrice;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
            color: Colors.red,
          )),
      actions: [
        Text(
          'сумма: \₸$totalPrice',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(width: 20)
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(300),
        child: SizedBox(height: 300, width: MediaQuery.of(context).size.width, child: WebViewWidget(controller: webViewController)),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 300);
}
