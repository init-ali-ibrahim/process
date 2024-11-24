import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:process/features/customize/presentation/bloc/customization_bloc.dart';
import 'package:process/features/customize/presentation/widgets/customize_appbar_widget.dart';
import 'package:process/features/customize/presentation/widgets/customize_body_content_widget.dart';
import 'package:process/features/customize/presentation/widgets/customize_side_menu_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class CustomizeScreen extends StatefulWidget {
  const CustomizeScreen({super.key});

  @override
  State<CustomizeScreen> createState() => _CustomizeScreenState();
}

class _CustomizeScreenState extends State<CustomizeScreen> {
  late WebViewController webViewController;
  String currentSelection = 'Shape';
  void _onSelectionChanged(String selection) {
    setState(() {
      currentSelection = selection;
    });
  }

  WebViewController _initializeWebViewController() {
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }
    final controller = WebViewController.fromPlatformCreationParams(params);
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('http://192.168.0.219:5173/'));
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController).setMediaPlaybackRequiresUserGesture(false);
    }
    return controller;
  }

  @override
  void initState() {
    super.initState();
    webViewController = _initializeWebViewController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomizationBloc(),
      child: BlocBuilder<CustomizationBloc, CustomizationState>(builder: (context, state) {
        return Scaffold(
            appBar: CustomizeAppbarWidget(webViewController: webViewController, totalPrice: state.totalPrice),
            body: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomizeSideMenuWidget(
                  currentSelection: currentSelection,
                  onSelectionChanged: _onSelectionChanged,
                  webViewController: webViewController,
                ),
                Expanded(
                  child: buildSelection(currentSelection, webViewController),
                ),
              ],
            ));
      }),
    );
  }
}
